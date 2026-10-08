;;; init-ui.el -*- lexical-binding: t; -*-

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "BerkeleyMono Nerd Font" :height 140))

(use-package base16-theme)

(load-theme 'darkmatter t)

(provide 'init-ui)
