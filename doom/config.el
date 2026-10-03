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

;; ZNC password: prompted once per session, kept only in memory
(defvar my/znc--password nil)

(defun my/znc-password (&rest _)
  (or my/znc--password
      (setq my/znc--password (read-passwd "ZNC password: "))))

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
