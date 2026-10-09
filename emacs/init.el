;;; init.el -*- lexical-binding: t; -*-

(defvar my/cache-dir (expand-file-name "emacs/" "~/.cache/")
  "Where state, backups and custom settings live (outside the dotfiles repo).")
(make-directory my/cache-dir t)

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(setq custom-file (expand-file-name "custom.el" my/cache-dir))
(load custom-file 'noerror 'nomessage)

;;; Packages
(require 'package)
(setq package-archives '(("gnu"    . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa"  . "https://melpa.org/packages/")))
(unless package-archive-contents (package-refresh-contents))
(setq use-package-always-ensure t)

(require 'init-defaults)
(require 'init-evil)
(require 'init-ui)
(require 'init-erc)
(require 'init-jabber)
(require 'init-mail)
(require 'init-lang)
(require 'init-tools)
(require 'init-term)
