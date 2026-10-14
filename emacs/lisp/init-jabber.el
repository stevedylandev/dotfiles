;;; init-jabber.el -*- lexical-binding: t; -*-

;; Built from git for OMEMO. Native module needs mbedtls 3.x headers, gcc,
;; make and pkg-config on PATH (4.x dropped mbedtls/aes.h).
(use-package jabber
  :vc (:url "https://git.thanosapollo.org/emacs-jabber"
            :lisp-dir "lisp"
            :shell-command "MBED_STATIC=1 make module")
  :defer t
  :init
  (with-eval-after-load 'jabber-roster-menu (require 'jabber))
  :config
  (setq jabber-account-list
        `(("stevedylandev@xmpp.is"
           (:password . ,(auth-source-pass-get 'secret "xmpp/stevedylandev@xmpp.is")))))
  (jabber-modeline-mode 1))

(with-eval-after-load 'jabber-omemo-trust
  (evil-define-key 'normal jabber-omemo-trust-mode-map
    "t" #'jabber-omemo-trust-set-verified
    "u" #'jabber-omemo-trust-set-untrusted
    "w" #'jabber-omemo-trust-copy-fingerprint
    "r" #'jabber-omemo-reset-session
    "d" #'jabber-omemo-trust-delete
    "G" #'jabber-omemo-trust-refresh
    "?" #'jabber-omemo-trust-menu))

(setq jabber-muc-decorate-presence-patterns
      '((".")))  ; "Hide all"

(provide 'init-jabber)
