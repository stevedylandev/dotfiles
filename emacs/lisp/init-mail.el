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

        mu4e-maildir-shortcuts
        '((:maildir "/local/Inbox"   :key ?i)
          (:maildir "/local/Sent"    :key ?s)
          (:maildir "/local/Drafts"  :key ?d)
          (:maildir "/local/Archive" :key ?a)
          (:maildir "/local/Trash"   :key ?t))))

(provide 'init-mail)
