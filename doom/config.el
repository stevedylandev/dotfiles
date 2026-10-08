;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

(setq doom-theme 'doom-darkmatter)
(setq doom-font (font-spec :family "BerkeleyMono Nerd Font" :size 14))
(setq display-line-numbers-type "relative")
(setq org-directory "~/org/")

(when (daemonp)
  (exec-path-from-shell-initialize))

(after! org
  (add-to-list 'org-capture-templates
               '("b" "Bookmark" entry (file "bookmarks.org")
                 "* [[%^{URL}][%^{Title}]] %^g\n:PROPERTIES:\n:ADDED: %U\n:END:\n%?"
                 :empty-lines 1)))

;; soju password: read from `pass' (gpg-encrypted), cached in memory per session
(require 'auth-source-pass)

(defvar my/soju-pass-entry "irc/soju")

(defvar my/soju--password nil)

(defun my/soju-password (&rest _)
  (or my/soju--password
      (setq my/soju--password
            (or (auth-source-pass-get 'secret my/soju-pass-entry)
                (user-error "No soju password in pass entry %s" my/soju-pass-entry)))))

(defun my/soju-user (client &optional network)
  "Build soju username for CLIENT on NETWORK (default libera)."
  (format "stevedylandev_/%s@%s" (or network "libera") client))

;; ERC via soju bouncer
(after! erc
  (setq erc-server "138.197.115.89"
        erc-port 6697
        erc-nick "stevedylandev_"
        erc-user-full-name "Steve Simkins"
        erc-prompt-for-password nil
        erc-track-shorten-start 8
        erc-kill-buffer-on-part t
        erc-kill-queries-on-quit t
        erc-hide-list '("JOIN" "PART" "QUIT")))

(defun my/erc-soju ()
  "Connect ERC to soju over TLS."
  (interactive)
  (erc-tls :server "138.197.115.89"
           :port 6697
           :nick "stevedylandev_"
           :user (my/soju-user "erc")
           :password (my/soju-password)))

(after! erc
  (add-to-list 'erc-modules 'nicks)
  (erc-update-modules)
  (setq erc-nicks-skip-nicks '("ChanServ" "NickServ")))

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
(load! "scripts/posts")

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

(after! jabber-omemo-trust
  (map! :map jabber-omemo-trust-mode-map
        :n "t" #'jabber-omemo-trust-set-verified
        :n "u" #'jabber-omemo-trust-set-untrusted
        :n "w" #'jabber-omemo-trust-copy-fingerprint
        :n "r" #'jabber-omemo-reset-session
        :n "d" #'jabber-omemo-trust-delete
        :n "G" #'jabber-omemo-trust-refresh
        :n "?" #'jabber-omemo-trust-menu))
