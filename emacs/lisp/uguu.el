;;; uguu.el --- Upload files to uguu.se -*- lexical-binding: t; -*-
;;
;;; Commentary:
;; `uguu-upload-file' and `uguu-upload-clipboard' upload to uguu.se and put
;; the resulting link in the kill ring.  In an ERC buffer the link is also
;; inserted at the prompt.  A prefix argument flips that behavior.
;;
;;; Code:

(require 'subr-x)

(defgroup uguu nil
  "Upload files to uguu.se."
  :group 'tools)

(defcustom uguu-endpoint "https://uguu.se/upload?output=text"
  "Upload URL.  `output=text' makes the response just the file link."
  :type 'string)

(defcustom uguu-insert-modes '(erc-mode)
  "Major modes where the link is inserted at point by default."
  :type '(repeat symbol))

(defun uguu--finish (url insert)
  "Copy URL to the kill ring, and insert it when INSERT is non-nil."
  (kill-new url)
  (when insert
    (when (derived-mode-p 'erc-mode)
      (goto-char (point-max)))
    (insert url))
  (message "Uploaded: %s%s" url (if insert "" " (copied)")))

(defun uguu--upload (file insert &optional cleanup)
  "Upload FILE asynchronously, then call `uguu--finish' with INSERT.
When CLEANUP is non-nil, delete FILE afterwards."
  (let ((buf (current-buffer))
        (out (generate-new-buffer " *uguu*")))
    (message "Uploading %s..." (file-name-nondirectory file))
    (make-process
     :name "uguu" :buffer out :noquery t
     :command (list "curl" "-sS" "--fail-with-body"
                    "-F" (concat "files[]=@" (expand-file-name file))
                    uguu-endpoint)
     :sentinel
     (lambda (proc _event)
       (when (memq (process-status proc) '(exit signal))
         (let ((resp (with-current-buffer out (string-trim (buffer-string)))))
           (kill-buffer out)
           (when cleanup (ignore-errors (delete-file file)))
           (if (and (zerop (process-exit-status proc))
                    (string-prefix-p "http" resp))
               (if (buffer-live-p buf)
                   (with-current-buffer buf (uguu--finish resp insert))
                 (uguu--finish resp nil))
             (message "Uguu upload failed: %s" resp))))))))

(defun uguu--insert-p (arg)
  "Whether to insert the link, given prefix ARG."
  (let ((default (apply #'derived-mode-p uguu-insert-modes)))
    (if arg (not default) default)))

;;;###autoload
(defun uguu-upload-file (file &optional arg)
  "Upload FILE to uguu.se.  Copy the link; insert it too in ERC.
With prefix ARG, flip whether the link is inserted."
  (interactive (list (read-file-name "Upload file: " nil nil t) current-prefix-arg))
  (uguu--upload file (uguu--insert-p arg)))

(defun uguu--clipboard-file ()
  "Return the path of a file copied in Finder/CleanShot, or nil.
Checked before the image data, which for a copied file is just its icon."
  (with-temp-buffer
    (when (zerop (call-process
                  "osascript" nil '(t nil) nil
                  "-e" "POSIX path of (the clipboard as «class furl»)"))
      (let ((path (string-trim (buffer-string))))
        (and (file-regular-p path) path)))))

(defun uguu--clipboard-image ()
  "Write the clipboard image to a temp PNG and return its path, or nil."
  (let ((tmp (make-temp-file "uguu-" nil ".png")))
    (if (zerop (call-process
                "osascript" nil nil nil
                "-e" (format "set f to open for access POSIX file %S with write permission"
                             tmp)
                "-e" "set eof f to 0"
                "-e" "write (the clipboard as «class PNGf») to f"
                "-e" "close access f"))
        tmp
      (delete-file tmp)
      nil)))

;;;###autoload
(defun uguu-upload-clipboard (&optional arg)
  "Upload the clipboard (an image, else text) to uguu.se.
With prefix ARG, flip whether the link is inserted."
  (interactive "P")
  (let* ((insert (uguu--insert-p arg))
         (file (uguu--clipboard-file))
         (img (and (not file) (uguu--clipboard-image))))
    (cond
     (file (uguu--upload file insert))
     (img (uguu--upload img insert t))
     (t
      (let ((text (or (ignore-errors (gui-get-selection 'CLIPBOARD 'STRING))
                      (car kill-ring)))
            (tmp (make-temp-file "uguu-" nil ".txt")))
        (unless (and text (not (string-empty-p text)))
          (user-error "Clipboard is empty"))
        (write-region text nil tmp nil 'silent)
        (uguu--upload tmp insert t))))))

(provide 'uguu)
;;; uguu.el ends here
