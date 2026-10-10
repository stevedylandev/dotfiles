;;; init-mail.el -*- lexical-binding: t; -*-

;; mu4e ships with Homebrew's `mu', not ELPA.
(use-package mu4e
  :ensure nil
  :load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e"
  :commands (mu4e mu4e-compose-new)
  :config
  (setq user-mail-address "contact@stevedylan.dev"

        ;; Fetching
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-change-filenames-when-moving t   ; required with mbsync

        ;; Folders (adjust to match `mbsync -l local`)
        mu4e-sent-folder   "/local/Sent"
        mu4e-drafts-folder "/local/Drafts"
        mu4e-trash-folder  "/local/Trash"
        mu4e-refile-folder "/local/Archive"

        ;; Sending via msmtp
        sendmail-program (executable-find "msmtp")
        send-mail-function #'sendmail-send-it
        message-send-mail-function #'message-send-mail-with-sendmail
        message-sendmail-envelope-from 'header
        message-kill-buffer-on-exit t

        ;; GPG
        mml-secure-openpgp-sign-with-sender t   ; pick key by From address
        mml-secure-openpgp-encrypt-to-self t    ; keep Sent copies readable
        mm-verify-option 'always                ; verify signatures on view
        mm-decrypt-option 'always               ; auto-decrypt on view

        mu4e-maildir-shortcuts
        '((:maildir "/local/Inbox"   :key ?i)
          (:maildir "/local/Sent"    :key ?s)
          (:maildir "/local/Drafts"  :key ?d)
          (:maildir "/local/Archive" :key ?a)
          (:maildir "/local/Trash"   :key ?t))))

;; Proton Bridge rewrites PGP/MIME into multipart/mixed with the armored
;; block as an attachment, so Emacs won't auto-decrypt. Pull the block out
;; of the raw message and decrypt it by hand.
(require 'mm-decode)
(require 'epg)
(require 'cl-lib)

(defun my/mail--pgp-blocks (path)
  "Return armored PGP message strings found in the parts of PATH."
  (with-temp-buffer
    (insert-file-contents-literally path)
    (let (blocks)
      (cl-labels ((walk (h)
                    (cond ((and (consp h) (stringp (car h)))
                           (mapc #'walk (cdr h)))
                          ((and (consp h) (bufferp (car h)))
                           (let ((s (mm-get-part h)))
                             (when (string-match "-----BEGIN PGP MESSAGE-----" s)
                               (push (substring s (match-beginning 0)) blocks)))))))
        (walk (mm-dissect-buffer t t)))
      (nreverse blocks))))

(defun my/mail-decrypt-bridge ()
  "Decrypt the PGP block of the mu4e message at point into a buffer."
  (interactive)
  (let* ((msg (mu4e-message-at-point))
         (blocks (or (my/mail--pgp-blocks (mu4e-message-field msg :path))
                     (user-error "No PGP block in message")))
         (ctx (epg-make-context 'OpenPGP))
         (buf (get-buffer-create "*mail-decrypted*")))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (dolist (b blocks)
          (insert (decode-coding-string
                   (epg-decrypt-string ctx b) 'utf-8)
                  "\n"))
        (goto-char (point-min))
        (special-mode)))
    (pop-to-buffer buf)))

(provide 'init-mail)
