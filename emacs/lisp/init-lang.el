;;; init-lang.el -*- lexical-binding: t; -*-

;;; Syntax highlighting: tree-sitter
(setopt treesit-enabled-modes t
        treesit-auto-install-grammar 'always
        treesit-font-lock-level 4)      ; 4 = everything (calls, properties, operators)

;;; LSP: eglot
(defvar my/lsp-servers
  '(((typescript-ts-mode tsx-ts-mode js-ts-mode) "vtsls" "--stdio")
    (rust-ts-mode       "rust-analyzer")
    ((go-ts-mode go-mod-ts-mode) "gopls")
    ((c-ts-mode c++-ts-mode) "clangd")
    (lua-ts-mode        "lua-language-server")
    ;;(css-ts-mode        "vscode-css-language-server" "--stdio")
    ((mhtml-ts-mode html-ts-mode) "vscode-html-language-server" "--stdio")
    (json-ts-mode       "vscode-json-language-server" "--stdio")
    (python-ts-mode     "pylsp")
    (python-ts-mode     "basedpyright-langserver" "--stdio") ; wins if both installed
    (bash-ts-mode       "bash-language-server" "start")
    (scheme-mode        "guile-lsp-server"))
  "Alist of (MODES SERVER ARGS...) used to auto-start eglot.")

(use-package eglot
  :ensure nil
  :defer t
  :custom
  (eglot-autoshutdown t)                ; kill server when last buffer closes
  (eglot-events-buffer-config '(:size 0 :format full)) ; no event logging
  (eglot-extend-to-xref t)              ; stay in eglot when jumping into deps
  :config
  (dolist (entry my/lsp-servers)
    (when (executable-find (cadr entry))
      (add-to-list 'eglot-server-programs
                   (cons (ensure-list (car entry)) (cdr entry))))))

;; Hooks go in now so eglot itself only loads when a matching buffer opens
(dolist (entry my/lsp-servers)
  (when (executable-find (cadr entry))
    (dolist (mode (ensure-list (car entry)))
      (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))))

;;; Indentation per language
(defvar my/indent-settings
  '(((typescript-ts-mode tsx-ts-mode) 2 nil typescript-ts-mode-indent-offset)
    (js-ts-mode                       2 nil js-indent-level)
    (rust-ts-mode                     4 nil rust-ts-mode-indent-offset)
    (go-ts-mode                       4 t   go-ts-mode-indent-offset)
    ((c-ts-mode c++-ts-mode)          4 nil c-ts-mode-indent-offset)
    (lua-ts-mode                      2 nil lua-ts-indent-offset)
    (css-ts-mode                      2 nil css-indent-offset)
    ((mhtml-ts-mode html-ts-mode)     2 nil html-ts-mode-indent-offset)
    (json-ts-mode                     2 nil json-ts-mode-indent-offset)
    (python-ts-mode                   4 nil python-indent-offset)
    (bash-ts-mode                     2 nil sh-basic-offset)
    ((emacs-lisp-mode scheme-mode)    2 nil nil))
  "List of (MODES WIDTH TABS OFFSET-VAR) applied in each mode's hook.")

(dolist (entry my/indent-settings)
  (pcase-let ((`(,modes ,width ,tabs ,var) entry))
    (dolist (mode (ensure-list modes))
      (add-hook (intern (format "%s-hook" mode))
                (lambda ()
                  (setq-local tab-width width
                              indent-tabs-mode tabs)
                  (when var (set (make-local-variable var) width)))))))

;;; Format on save
;; Uses eglot when the server can format, else re-indents lisp buffers.  Off for a
;; buffer with SPC c F, or per project via .dir-locals.el:
(defvar my/format-on-save t
  "Non-nil formats eglot-managed buffers before saving.")
(put 'my/format-on-save 'safe-local-variable #'booleanp)

(defvar my/reindent-modes '(emacs-lisp-mode scheme-mode)
  "Modes without an LSP formatter that format by re-indenting the buffer.")

(defun my/format-buffer ()
  "Format with eglot if the server can, else re-indent in `my/reindent-modes'."
  (interactive)
  (cond ((and (fboundp 'eglot-managed-p) (eglot-managed-p)
              (eglot-server-capable :documentFormattingProvider))
         (eglot-format-buffer))
        ((apply #'derived-mode-p my/reindent-modes)
         (indent-region (point-min) (point-max)))
        ((called-interactively-p 'any)
         (message "No formatter for %s" major-mode))))

(defun my/format-on-save ()
  (when my/format-on-save (my/format-buffer)))

(add-hook 'before-save-hook #'my/format-on-save)

(defun my/toggle-format-on-save ()
  "Toggle format on save for the current buffer."
  (interactive)
  (setq-local my/format-on-save (not my/format-on-save))
  (message "Format on save %s" (if my/format-on-save "on" "off")))

;; Diagnostics
(setq flymake-show-diagnostics-at-end-of-line 'short)

(with-eval-after-load 'general
  (my/leader
    "c"   '(:ignore t :wk "code")
    "ca"  '(eglot-code-actions :wk "actions")
    "cr"  '(eglot-rename :wk "rename")
    "cf"  '(my/format-buffer :wk "format")
    "cF"  '(my/toggle-format-on-save :wk "toggle format on save")
    "cd"  '(xref-find-definitions :wk "definition")
    "cR"  '(xref-find-references :wk "references")
    "ci"  '(eglot-find-implementation :wk "implementation")
    "ct"  '(eglot-find-typeDefinition :wk "type def")
    "ce"  '(flymake-show-buffer-diagnostics :wk "errors")
    "cE"  '(flymake-show-project-diagnostics :wk "project errors")
    "cn"  '(flymake-goto-next-error :wk "next error")
    "cp"  '(flymake-goto-prev-error :wk "prev error")
    "cl"  '(eglot :wk "start lsp")
    "cL"  '(eglot-shutdown :wk "stop lsp")))

(provide 'init-lang)
