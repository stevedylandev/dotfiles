;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq doom-theme 'doom-darkmatter)
(setq display-line-numbers-type "relative")
(setq org-directory "~/org/")

(after! org
  (add-to-list 'org-capture-templates
               '("b" "Bookmark" entry (file "bookmarks.org")
                 "* [[%^{URL}][%^{Title}]] %^g\n:PROPERTIES:\n:ADDED: %U\n:END:\n%?"
                 :empty-lines 1)))

;; ZNC password: read from `pass' (gpg-encrypted), cached in memory per session
(require 'auth-source-pass)

(defvar my/znc-pass-entry "irc/znc"
  "Entry in the password store holding the ZNC password.")

(defvar my/znc--password nil)

(defun my/znc-password (&rest _)
  (or my/znc--password
      (setq my/znc--password
            (or (auth-source-pass-get 'secret my/znc-pass-entry)
                (user-error "No ZNC password in pass entry %s" my/znc-pass-entry)))))

(defun my/znc-pass (client)
  "Build ZNC server password for CLIENT."
  (concat "stevedylandev_@" client "/libera:" (my/znc-password)))

;; Prompt before connecting, not mid-handshake
(defadvice! my/irc-ask-password-a (&rest _)
  :before #'+irc/connect
  (my/znc-password))

(set-irc-server! "znc"
  `(:host "138.197.115.89"
    :port 6697
    :tls t
    :nick "stevedylandev_"
    :pass ,(lambda (&rest _) (my/znc-pass "emacs"))))

(after! elfeed-org
  (setq rmh-elfeed-org-files (list "~/org/elfeed.org")))

(defvar my/dashboard-banner-file (expand-file-name "banner.txt" doom-user-dir)
  "Text file holding the ASCII banner for the Doom dashboard.")

(defun my/file-ascii-banner ()
  (if (file-readable-p my/dashboard-banner-file)
      (propertize
       (with-temp-buffer
         (insert-file-contents my/dashboard-banner-file)
         (string-trim-right (buffer-string)))
       'face '+dashboard-banner)
    (+dashboard-draw-ascii-banner-fn)))

(setq +dashboard-ascii-banner-fn #'my/file-ascii-banner)

 (custom-set-faces!
    `(+dashboard-banner :foreground ,(doom-color 'white)))

(setq +dashboard-functions
        '(+dashboard-widget-banner
          +dashboard-widget-loaded))

(add-to-list 'load-path "/opt/homebrew/share/emacs/site-lisp/mu/mu4e")

;; Make GUI Emacs see Homebrew binaries (mbsync, msmtp, pass, gpg)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))   ; needs the exec-path-from-shell package

(require 'mu4e)

(setq user-mail-address "contact@stevedylan.dev"
      user-full-name "Steve Simkins"

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
        (:maildir "/local/Trash"   :key ?t)))

(after! gptel
  (setq gptel-model 'claude-sonnet-5-5
        gptel-backend
        (gptel-make-anthropic "Claude"
          :stream t
          :key #'gptel-api-key
          :models '(claude-sonnet-5-5 claude-opus-5-5 claude-haiku-4-5-20251001))))

(after! jabber
  (setq jabber-account-list
        `(("stevedylandev@xmpp.is"
           (:password . ,(auth-source-pass-get 'secret "xmpp/stevedylandev@xmpp.is")))))
  (jabber-modeline-mode 1)
  (map! :leader "o j" #'jabber-roster)) ; optional binding
