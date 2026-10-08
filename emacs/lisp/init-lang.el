;;; init-lang.el -*- lexical-binding: t; -*-

;;; Syntax highlighting: tree-sitter (built-in)
;; Every built-in *-ts-mode replaces its classic mode, and the grammar is
;; compiled into ~/.config/emacs/tree-sitter the first time it's needed.
;; Needs a C compiler (xcode-select --install).
(setopt treesit-enabled-modes t
        treesit-auto-install-grammar 'always
        treesit-font-lock-level 4)      ; 4 = everything (calls, properties, operators)

;;; LSP: eglot (built-in)
;; Add a language: one line here.  MODES is a ts-mode (or list of them),
;; SERVER is the command eglot runs.  Entries whose server binary isn't on
;; PATH are skipped, so it's fine to list servers you haven't installed.
;; A mode not built into Emacs needs its package first, e.g.
;;   (use-package zig-mode)  then  (zig-mode "zls")
(defvar my/lsp-servers
  '(((typescript-ts-mode tsx-ts-mode js-ts-mode) "vtsls" "--stdio")
    (rust-ts-mode       "rust-analyzer")
    ((go-ts-mode go-mod-ts-mode) "gopls")
    ((c-ts-mode c++-ts-mode) "clangd")
    (lua-ts-mode        "lua-language-server")
    (css-ts-mode        "vscode-css-language-server" "--stdio")
    ((mhtml-ts-mode html-ts-mode) "vscode-html-language-server" "--stdio")
    (json-ts-mode       "vscode-json-language-server" "--stdio")
    (python-ts-mode     "basedpyright-langserver" "--stdio")
    (bash-ts-mode       "bash-language-server" "start"))
  "Alist of (MODES SERVER ARGS...) used to auto-start eglot.")

(use-package eglot
  :ensure nil
  :custom
  (eglot-autoshutdown t)                ; kill server when last buffer closes
  (eglot-events-buffer-config '(:size 0 :format full)) ; no event logging
  (eglot-extend-to-xref t)              ; stay in eglot when jumping into deps
  :config
  (dolist (entry my/lsp-servers)
    (let ((modes (ensure-list (car entry)))
          (cmd (cdr entry)))
      (when (executable-find (car cmd))
        (add-to-list 'eglot-server-programs (cons modes cmd))
        (dolist (mode modes)
          (add-hook (intern (format "%s-hook" mode)) #'eglot-ensure))))))

;; Diagnostics
(setq flymake-show-diagnostics-at-end-of-line 'short)

(with-eval-after-load 'general
  (my/leader
    "c"   '(:ignore t :wk "code")
    "ca"  '(eglot-code-actions :wk "actions")
    "cr"  '(eglot-rename :wk "rename")
    "cf"  '(eglot-format-buffer :wk "format")
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
