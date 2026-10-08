;;; init-erc.el -*- lexical-binding: t; -*-

(require 'auth-source-pass)

;; soju password: read from `pass' (gpg-encrypted), cached in memory per session
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

(with-eval-after-load 'erc
  (setq erc-server "138.197.115.89"
        erc-port 6697
        erc-nick "stevedylandev_"
        erc-user-full-name "Steve Simkins"
        erc-prompt-for-password nil
        erc-track-shorten-start 8
        erc-kill-buffer-on-part t
        erc-kill-queries-on-quit t
        erc-hide-list '("JOIN" "PART" "QUIT")
        erc-nicks-skip-nicks '("ChanServ" "NickServ"))
  (add-to-list 'erc-modules 'nicks)
  (erc-update-modules))

(defun my/erc-soju ()
  "Connect ERC to soju over TLS."
  (interactive)
  (erc-tls :server "138.197.115.89"
           :port 6697
           :nick "stevedylandev_"
           :user (my/soju-user "erc")
           :password (my/soju-password)))

(provide 'init-erc)
