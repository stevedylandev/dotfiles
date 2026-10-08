;;; early-init.el -*- lexical-binding: t; -*-

;; Faster startup: defer GC, restore after init
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024))))

;; Skip UI chrome before first frame draws
(setq package-enable-at-startup t
      inhibit-startup-screen t
      frame-inhibit-implied-resize t)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(background-color . "#121113") default-frame-alist)
(push '(foreground-color . "#c1c1c1") default-frame-alist)

;; Keep native-comp noise quiet
(setq native-comp-async-report-warnings-errors 'silent)
