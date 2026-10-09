;;; init-defaults.el -*- lexical-binding: t; -*-

(setq user-full-name "Steve Simkins")

;; Backups, autosaves, lockfiles: keep out of project dirs
(let ((dir (expand-file-name "backups/" my/cache-dir)))
  (make-directory dir t)
  (setq backup-directory-alist `(("." . ,dir))
        auto-save-file-name-transforms `((".*" ,dir t))
        create-lockfiles nil
        backup-by-copying t
        delete-old-versions t
        version-control t))

(setq save-place-file (expand-file-name "places" my/cache-dir)
      savehist-file (expand-file-name "history" my/cache-dir)
      recentf-save-file (expand-file-name "recentf" my/cache-dir)
      recentf-max-saved-items 200)

;; Sane editing
(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 80)
(setq sentence-end-double-space nil
      require-final-newline t
      ring-bell-function #'ignore
      use-short-answers t
      confirm-kill-emacs #'y-or-n-p
      scroll-conservatively 101
      scroll-margin 3
      mouse-wheel-progressive-speed nil
      load-prefer-newer t
      read-process-output-max (* 1024 1024))

;; Responsiveness / latency
(setq fast-but-imprecise-scrolling t
      redisplay-skip-fontification-on-input t
      inhibit-compacting-font-caches t
      treesit-font-lock-level 2
      icomplete-compute-delay 0.01
      show-paren-delay 0.05
      which-key-idle-delay 0.5
      tooltip-delay 0.3
      tooltip-short-delay 0.08)

;; Built-in minor modes worth having
(delete-selection-mode 1)
(electric-pair-mode 1)
(show-paren-mode 1)
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(global-so-long-mode 1)
(repeat-mode 1)
(column-number-mode 1)
(pixel-scroll-precision-mode 1)

;; Completion (built-in, no packages)
(setq completion-styles '(basic partial-completion flex)
      completions-detailed t
      completion-auto-help 'visible
      completion-auto-select 'second-tab
      tab-always-indent 'complete
      read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t)
(fido-vertical-mode 1)

;; Line numbers in code/text, relative like Doom config
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)

;; Trim trailing whitespace on save
(add-hook 'before-save-hook #'delete-trailing-whitespace)

;; macOS
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'super
        mac-option-modifier 'meta
        ns-use-proxy-icon nil))

;; GUI emacs: pick up shell PATH (brew, pass, gpg)
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :config (exec-path-from-shell-initialize))

(use-package which-key
  :ensure nil
  :init (which-key-mode 1))

(provide 'init-defaults)
