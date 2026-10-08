;;; init-jabber.el -*- lexical-binding: t; -*-

(require 'auth-source-pass)

;; Built from git for OMEMO. Native module needs `brew install mbedtls@3'
;; (4.x dropped mbedtls/aes.h); macOS has no getrandom, so shim it.
(use-package jabber
  :vc (:url "https://git.thanosapollo.org/emacs-jabber"
       :lisp-dir "lisp"
       :shell-command "PKG_CONFIG_PATH=/opt/homebrew/opt/mbedtls@3/lib/pkgconfig CFLAGS=\"-I/opt/homebrew/opt/emacs/include '-Dgetrandom(b,n,f)=(arc4random_buf((b),(n)),(ssize_t)(n))'\" MBED_STATIC=1 make module")
  :defer t
  :init
  ;; `jabber-roster' autoloads from jabber-roster-menu, which never loads
  ;; jabber.el, so :config (account list) would never run. Pull it in.
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

(provide 'init-jabber)
