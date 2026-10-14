;;; posts.el --- Emacs extension for Andromeda/Posts -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2026 Steve Simkins
;;
;; Author: Steve Simkins <contact@stevedylan.dev>
;; Version: 0.0.1
;; Keywords: tools blogging extension
;; Homepage: https://github.com/stevedylandev/andromeda
;; Package-Requires: ((emacs "27.1"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;; Sends micro posts to an Andromeda/posts instance.
;; Run M-x posts-compose, fill in the `name: value' fields at the top
;; (see `posts-fields'), write the content below, then press C-c C-c.
;;
;;; Code:

(require 'url)
(require 'json)
(require 'mailcap)
(require 'subr-x)
(require 'auth-source-pass)

(defgroup posts nil
  "Andromeda/posts."
  :group 'tools)

(defcustom posts-pass-entry "andromeda/posts-api-key"
  "Name of the `pass' entry holding the API key."
  :type 'string
  :group 'posts)

(defun posts--api-key ()
  "Return the API key from password-store."
  ;; Encode so the header is unibyte; otherwise url-http refuses to mix
  ;; it with a binary request body.
  (encode-coding-string
   (or (auth-source-pass-get 'secret posts-pass-entry)
       (user-error "No pass entry `%s'" posts-pass-entry))
   'utf-8))

(defcustom posts-endpoint "https://posts.stevedylan.dev/api/posts"
  "URL that receives the JSON post."
  :type 'string
  :group 'posts)

(defcustom posts-files-endpoint "https://posts.stevedylan.dev/api/files"
  "URL that receives multipart file uploads."
  :type 'string
  :group 'posts)

(defconst posts--max-file-size (* 10 1024 1024)
  "Largest file the server accepts, in bytes.")

;;;; Fields

(defcustom posts-fields
  '(("title")
    ("status" :default "draft" :choices ("draft" "published")))
  "Header fields read from the top of the compose buffer as `name: value'.
Each entry is (NAME . PLIST).  PLIST keys: `:required', `:default',
`:choices'.  Add an entry to support a new field; it is sent as a JSON
key of the same name."
  :type '(alist :key-type string :value-type plist)
  :group 'posts)

(defun posts--parse-buffer ()
  "Return (FIELDS . CONTENT) parsed from the current buffer.
FIELDS is an alist of raw (NAME . VALUE) strings from the leading
`name: value' lines.  CONTENT is everything after them."
  (save-excursion
    (goto-char (point-min))
    (let (fields)
      (while (looking-at "^\\([[:alnum:]_-]+\\):[ \t]*\\(.*?\\)[ \t]*$")
        (push (cons (downcase (match-string-no-properties 1))
                    (match-string-no-properties 2))
              fields)
        (forward-line 1))
      (cons (nreverse fields)
            (string-trim
             (buffer-substring-no-properties (point) (point-max)))))))

(defun posts--resolve-fields (parsed)
  "Validate PARSED against `posts-fields'; return alist with defaults applied."
  (dolist (p parsed)
    (unless (assoc (car p) posts-fields)
      (user-error "Unknown field `%s'" (car p))))
  (delq nil
        (mapcar
         (lambda (spec)
           (let* ((name (car spec))
                  (opts (cdr spec))
                  (raw (cdr (assoc name parsed)))
                  (val (if (and raw (not (string-empty-p raw)))
                           raw
                         (plist-get opts :default)))
                  (choices (plist-get opts :choices)))
             (when (and (plist-get opts :required) (null val))
               (user-error "Field `%s' is required" name))
             (when (and val choices (not (member val choices)))
               (user-error "Bad %s `%s' (one of: %s)"
                           name val (string-join choices ", ")))
             (and val (cons name val))))
         posts-fields)))

(defun posts--payload (fields content)
  "Build the JSON plist from FIELDS alist and CONTENT."
  (append (mapcan (lambda (f) (list (intern (concat ":" (car f))) (cdr f)))
                  fields)
          (list :content content)))

;;;; Sending

(defun posts (fields content)
  "Send a post to `posts-endpoint' as JSON.
FIELDS is an alist of (NAME . VALUE) strings, CONTENT the body."
  (interactive
   (let ((title (read-string "Title (optional): ")))
     (list (delq nil (list (and (not (string-empty-p title))
                                (cons "title" title))
                           (cons "status" "draft")))
           (read-string "Content: "))))
  (let ((url-request-method "POST")
        (url-request-extra-headers
         `(("Content-Type" . "application/json; charset=utf-8")
           ("X-API-Key" . ,(posts--api-key))))
        (url-request-data
         (encode-coding-string
          (json-serialize (posts--payload fields content))
          'utf-8)))
    (url-retrieve
     posts-endpoint
     (lambda (status)
       (unwind-protect
           (if (plist-get status :error)
               (message "Posts error: %S" (plist-get status :error))
             (goto-char (point-min))
             (re-search-forward "\r?\n\r?\n" nil t)
             (condition-case nil
                 (let ((resp (json-parse-buffer :object-type 'alist)))
                   (message "Posted: https://stevedylan.dev/now/%S" (alist-get 'slug resp)))
               (error (message "Posted (non-JSON response)"))))
         (kill-buffer (current-buffer))))
     nil t)))

;;;; Uploading files

(defun posts--multipart-body (boundary file name)
  "Return a unibyte multipart/form-data body for FILE using BOUNDARY.
NAME, when non-nil, is sent as the `name' field."
  (let ((type (or (mailcap-file-name-to-mime-type file)
                  "application/octet-stream"))
        (filename (replace-regexp-in-string
                   "\"" "\\\\\""
                   (encode-coding-string (file-name-nondirectory file) 'utf-8))))
    (with-temp-buffer
      (set-buffer-multibyte nil)
      (when name
        (insert "--" boundary "\r\n"
                "Content-Disposition: form-data; name=\"name\"\r\n\r\n"
                (encode-coding-string name 'utf-8) "\r\n"))
      (insert "--" boundary "\r\n"
              "Content-Disposition: form-data; name=\"file\"; filename=\""
              filename "\"\r\n"
              "Content-Type: " type "\r\n\r\n")
      (insert-file-contents-literally file)
      (goto-char (point-max))
      (insert "\r\n--" boundary "--\r\n")
      (buffer-string))))

(defun posts--response-json ()
  "Parse the JSON body of the current HTTP response buffer, or nil."
  (goto-char (point-min))
  (when (re-search-forward "\r?\n\r?\n" nil t)
    (ignore-errors (json-parse-buffer :object-type 'alist))))

(defun posts-upload-file (file &optional name callback)
  "Upload FILE to `posts-files-endpoint'.
NAME, if non-empty, sets the stored filename.  On success the file's
URL is copied to the kill ring and CALLBACK, if non-nil, is called
with the parsed response alist."
  (interactive
   (list (read-file-name "Upload file: " nil nil t)
         (read-string "Name (optional): ")))
  (setq file (expand-file-name file))
  (unless (file-regular-p file)
    (user-error "Not a regular file: %s" file))
  (when (> (file-attribute-size (file-attributes file)) posts--max-file-size)
    (user-error "File exceeds 10 MB: %s" file))
  (when (and name (string-empty-p (string-trim name)))
    (setq name nil))
  (let* ((boundary (format "posts-%s" (md5 (format "%s%s" (random) (float-time)))))
         (url-request-method "POST")
         (url-request-extra-headers
          `(("Content-Type" . ,(encode-coding-string
                                (concat "multipart/form-data; boundary=" boundary)
                                'utf-8))
            ("X-API-Key" . ,(posts--api-key))))
         (url-request-data (posts--multipart-body boundary file name)))
    (message "Uploading %s..." (file-name-nondirectory file))
    (url-retrieve
     posts-files-endpoint
     (lambda (status)
       (unwind-protect
           (let ((err (plist-get status :error))
                 (resp (posts--response-json)))
             (cond
              ((equal err '(error http 409))
               (message "Upload failed: name `%s' is already taken" name))
              (err
               (message "Upload error: %S%s" err
                        (if resp (format " %S" resp) "")))
              ((null (alist-get 'url resp))
               (message "Uploaded (unexpected response)"))
              (t
               (kill-new (alist-get 'url resp))
               (message "Uploaded: %s (copied)" (alist-get 'url resp))
               (when callback (funcall callback resp)))))
         (kill-buffer (current-buffer))))
     nil t)))

;;;; Compose buffer

(defvar posts-compose-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "C-c C-c") #'posts-compose-submit)
    (define-key m (kbd "C-c C-k") #'posts-compose-cancel)
    (define-key m (kbd "C-c C-a") #'posts-compose-attach)
    m)
  "Keymap for `posts-compose-mode'.")

(define-derived-mode posts-compose-mode text-mode "Posts"
  "Compose a post.  Leading `name: value' lines are fields, the rest is content.
\\{posts-compose-mode-map}"
  (setq header-line-format
        "Fields as `name: value' lines, then content.  C-c C-c send, C-c C-a attach file, C-c C-k cancel"))

;;;###autoload
(defun posts-compose ()
  "Open a buffer to compose a post."
  (interactive)
  (pop-to-buffer (get-buffer-create "*posts-compose*"))
  (erase-buffer)
  (posts-compose-mode)
  (dolist (spec posts-fields)
    (insert (car spec) ": " (or (plist-get (cdr spec) :default) "") "\n"))
  (insert "\n")
  (goto-char (point-min))
  (end-of-line))

(defun posts-compose-submit ()
  "Parse the compose buffer and send it."
  (interactive)
  (let* ((parsed (posts--parse-buffer))
         (fields (posts--resolve-fields (car parsed)))
         (content (cdr parsed)))
    (when (string-empty-p content)
      (user-error "Content is empty"))
    (posts fields content)
    (quit-window t)))

(defun posts-compose-attach (file &optional name)
  "Upload FILE (stored as NAME) and insert a Markdown link at point.
Images are inserted as `![](url)'."
  (interactive
   (list (read-file-name "Attach file: " nil nil t)
         (read-string "Name (optional): ")))
  (let ((marker (point-marker)))
    (posts-upload-file
     file name
     (lambda (resp)
       (when (buffer-live-p (marker-buffer marker))
         (with-current-buffer (marker-buffer marker)
           (save-excursion
             (goto-char marker)
             (insert (format "%s[%s](%s)"
                             (if (string-prefix-p "image/" (or (alist-get 'content_type resp) ""))
                                 "!" "")
                             (or (alist-get 'original_name resp)
                                 (alist-get 'filename resp) "")
                             (alist-get 'url resp))))))))))

(defun posts-compose-cancel ()
  "Discard the compose buffer."
  (interactive)
  (quit-window t))

(provide 'posts)
;;; posts.el ends here
