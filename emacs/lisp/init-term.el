;;; init-term.el -*- lexical-binding: t; -*-

;; Ghostel: libghostty-vt backed terminal. Native module downloads on first use.
(use-package ghostel
  :commands (ghostel ghostel-project)
  :init
  (setq ghostel-timer-delay 0.01
        ghostel-max-scrollback (* 1024 1024)))

(use-package evil-ghostel
  :after (ghostel evil)
  :hook (ghostel-mode . evil-ghostel-mode))

;; Terminal perf tweaks, adapted from James Cherti (MIT):
;; https://www.jamescherti.com/emacs-terminal-performance-vterm-eat-ansi-term-ghostel/
(defun my/speed-up-terminal-buffer ()
  "Reduce unnecessary Emacs features in terminal buffers."
  (let ((ghostel-buffer (derived-mode-p 'ghostel-mode)))
    (setq-local font-lock-defaults '(nil t))

    (setq-local scroll-conservatively most-positive-fixnum)
    (setq-local hscroll-margin 0)
    (setq-local scroll-margin 0)
    (setq-local auto-hscroll-mode nil)

    (setq-local truncate-lines t)
    (setq-local nobreak-char-display nil)
    (setq-local bidi-paragraph-direction 'left-to-right)
    (setq-local bidi-inhibit-bpa t)

    ;; Ghostel computes row height from ghostel-line-spacing
    (unless ghostel-buffer
      (setq-local line-spacing 0)
      (setq-local mode-line-format nil))

    (setq-local process-adaptive-read-buffering nil)
    (let ((output-max (* 1024 1024)))
      (when (< read-process-output-max output-max)
        (setq-local read-process-output-max output-max)))

    (buffer-disable-undo)

    ;; Evil jump list hooks (C-o / C-i won't work in terminals)
    (remove-hook 'pre-command-hook 'evil--jump-hook t)
    (remove-hook 'post-command-hook 'evil--jump-handle-buffer-crossing t)

    (let ((inhibit-redisplay t)
          (inhibit-message t)
          (modes (list 'electric-pair-local-mode
                       'electric-indent-local-mode
                       'display-line-numbers-mode
                       'display-fill-column-indicator-mode
                       'hl-line-mode
                       'show-paren-local-mode
                       'flymake-mode
                       'flycheck-mode
                       'evil-surround-mode
                       'yas-minor-mode
                       'company-mode
                       'corfu-mode)))
      ;; Ghostel relies on eldoc (link targets) and auto-composition
      (unless ghostel-buffer
        (push 'eldoc-mode modes)
        (push 'auto-composition-mode modes))
      (dolist (mode modes)
        (when (fboundp mode)
          (ignore-errors (funcall mode -1)))))))

(add-hook 'term-mode-hook #'my/speed-up-terminal-buffer t)
(add-hook 'ghostel-mode-hook #'my/speed-up-terminal-buffer t)

(provide 'init-term)
