;;; early-init.el -*- lexical-binding: t; -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 1.0)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 16 1024 1024)
                           gc-cons-percentage 0.1)))

;; Every `load'/`require' checks file names against these regexps; skip that
;; during init and restore afterwards (adapted from minimal-emacs.d)
(let ((handlers file-name-handler-alist))
  ;; keep jka-compr so compressed .el.gz libraries still load
  (setq file-name-handler-alist (list (rassq 'jka-compr-handler handlers)))
  (add-hook 'emacs-startup-hook
            (lambda ()
              (setq file-name-handler-alist
                    (delete-dups (append file-name-handler-alist handlers))))
            101))

(setq package-enable-at-startup t
      inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name
      frame-inhibit-implied-resize t
      frame-resize-pixelwise t
      auto-mode-case-fold nil)

;; Skip UI chrome before first frame draws
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(background-color . "#121113") default-frame-alist)
(push '(foreground-color . "#c1c1c1") default-frame-alist)

;; macOS: blend the title bar into the frame background
(when (eq system-type 'darwin)
  (push '(ns-transparent-titlebar . t) default-frame-alist)
  (push '(ns-appearance . dark) default-frame-alist)
  (setq ns-use-proxy-icon nil
        frame-title-format nil))

;; Keep native-comp noise quiet
(setq native-comp-async-report-warnings-errors 'silent)
