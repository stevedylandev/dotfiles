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
;; Run M-x posts-compose, write the title on the first line and the
;; content below it, then press C-c C-c to send.
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

;;;; Sending

(defun posts (title content)
  "Send a post with TITLE and CONTENT to `posts-endpoint' as JSON."
  (interactive
   (list (read-string "Title: ")
         (read-string "Content: ")))
  (let ((url-request-method "POST")
        (url-request-extra-headers
         `(("Content-Type" . "application/json; charset=utf-8")
           ("X-API-Key" . ,(posts--api-key))))
        (url-request-data
         (encode-coding-string
          (json-serialize `(:title ,title :content ,content :status "draft"))
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
  "Compose a post.  First line is the title, the rest is content.
\\{posts-compose-mode-map}"
  (setq header-line-format
        "Title on first line.  C-c C-c to send, C-c C-k to cancel"))

;;;###autoload
(defun posts-compose ()
  "Open a buffer to compose a post."
  (interactive)
  (pop-to-buffer (get-buffer-create "*posts-compose*"))
  (erase-buffer)
  (posts-compose-mode))

(defun posts-compose-submit ()
  "Parse the compose buffer and send it."
  (interactive)
  (let* ((title (save-excursion
                  (goto-char (point-min))
                  (string-trim
                   (buffer-substring-no-properties
                    (line-beginning-position) (line-end-position)))))
         (content (save-excursion
                    (goto-char (point-min))
                    (forward-line 1)
                    (string-trim
                     (buffer-substring-no-properties (point) (point-max))))))
    (when (string-empty-p title)
      (user-error "Title is empty"))
    (posts title content)
    (quit-window t)))

(defun posts-compose-cancel ()
  "Discard the compose buffer."
  (interactive)
  (quit-window t))

(provide 'posts)
;;; posts.el ends here
