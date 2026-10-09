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
  (or (auth-source-pass-get 'secret posts-pass-entry)
      (user-error "No pass entry `%s'" posts-pass-entry)))

(defcustom posts-endpoint "https://posts.stevedylan.dev/api/posts"
  "URL that receives the JSON post."
  :type 'string
  :group 'posts)

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

;;;; Compose buffer

(defvar posts-compose-mode-map
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "C-c C-c") #'posts-compose-submit)
    (define-key m (kbd "C-c C-k") #'posts-compose-cancel)
    m)
  "Keymap for `posts-compose-mode'.")

(define-derived-mode posts-compose-mode text-mode "Posts"
  "Compose a post.  Leading `name: value' lines are fields, the rest is content.
\\{posts-compose-mode-map}"
  (setq header-line-format
        "Fields as `name: value' lines, then content.  C-c C-c to send, C-c C-k to cancel"))

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

(defun posts-compose-cancel ()
  "Discard the compose buffer."
  (interactive)
  (quit-window t))

(provide 'posts)
;;; posts.el ends here
