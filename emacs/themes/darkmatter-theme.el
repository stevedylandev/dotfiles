;;; darkmatter-theme.el --- Darkmatter on base16 -*- lexical-binding: t; -*-

;; https://darkmattertheme.com
;; Palette + a few overrides on top of `base16-theme' (package base16-theme).
;; The 16 slots are mapped to match the old doom-darkmatter roles.

(require 'cl-lib)
(require 'base16-theme)

;;; Palette -- edit these and everything below follows

(defun darkmatter--blend (a b alpha)
  "Mix hex colors A and B; ALPHA is the share of B (0..1)."
  (cl-flet ((rgb (c) (mapcar (lambda (i) (string-to-number (substring c i (+ i 2)) 16))
                             '(1 3 5))))
    (apply #'format "#%02x%02x%02x"
           (cl-mapcar (lambda (x y) (round (+ (* x (- 1 alpha)) (* y alpha))))
                      (rgb a) (rgb b)))))

(defvar darkmatter-palette
  '((base00 . "#121113")   ; background
    (base01 . "#121212")   ; lighter background
    (base02 . "#222222")   ; selection
    (base03 . "#333333")   ; comments
    (base04 . "#999999")   ; dark foreground, doc strings
    (base05 . "#c1c1c1")   ; foreground
    (base06 . "#999999")   ; light foreground
    (base07 . "#c1c1c1")   ; lightest
    (base08 . "#5f8787")   ; variables, errors
    (base09 . "#aaaaaa")   ; constants, numbers
    (base0A . "#e78a53")   ; types, accent, warnings
    (base0B . "#fbcb97")   ; strings, added
    (base0C . "#aaaaaa")   ; builtins, support
    (base0D . "#888888")   ; functions
    (base0E . "#999999")   ; keywords
    (base0F . "#444444")   ; deprecated
    (red    . "#aa6c6c"))  ; extra: removed lines, ERC errors (not a base16 slot)
  "Darkmatter colors. Base16 slots plus `red'. Everything else is derived.")

(deftheme darkmatter "Darkmatter, based on Black Metal Bathory.")

(let* ((base00 (alist-get 'base00 darkmatter-palette))
       (base01 (alist-get 'base01 darkmatter-palette))
       (base02 (alist-get 'base02 darkmatter-palette))
       (base03 (alist-get 'base03 darkmatter-palette))
       (base04 (alist-get 'base04 darkmatter-palette))
       (base05 (alist-get 'base05 darkmatter-palette))
       (base06 (alist-get 'base06 darkmatter-palette))
       (base07 (alist-get 'base07 darkmatter-palette))
       (base08 (alist-get 'base08 darkmatter-palette))
       (base09 (alist-get 'base09 darkmatter-palette))
       (base0A (alist-get 'base0A darkmatter-palette))
       (base0B (alist-get 'base0B darkmatter-palette))
       (base0C (alist-get 'base0C darkmatter-palette))
       (base0D (alist-get 'base0D darkmatter-palette))
       (base0E (alist-get 'base0E darkmatter-palette))
       (base0F (alist-get 'base0F darkmatter-palette))
       (red    (alist-get 'red darkmatter-palette))
       ;; roles used by the face overrides below
       (bg      base00)
       (bg-alt  base01)
       (sel     base02)
       (comment base03)
       (dim     base04)
       (fg      base05)
       (fg-hi   base06)
       (fg-max  base07)
       (teal    base08)
       (const   base09)
       (orange  base0A)
       (string  base0B)
       (func    base0D)
       (kw      base0E)
       (dep     base0F)
       ;; derived
       (base0          (darkmatter--blend bg "#000000" 0.4))
       (faint          (darkmatter--blend bg-alt kw 0.2))
       (muted          (darkmatter--blend bg dim 0.45))
       (bg-tint        (darkmatter--blend bg const 0.15))
       (added-fg       (darkmatter--blend string "#000000" 0.2))
       (added-bg       (darkmatter--blend bg string 0.1))
       (added-bg-hi    (darkmatter--blend bg string 0.2))
       (removed-bg     (darkmatter--blend sel red 0.1))
       (removed-bg-hi  (darkmatter--blend sel red 0.2))
       (changed-bg     (darkmatter--blend bg orange 0.1))
       (changed-bg-hi  (darkmatter--blend bg orange 0.2))
       (red-dark       (darkmatter--blend red "#000000" 0.2))
       (orange-dark    (darkmatter--blend orange "#000000" 0.2)))

  ;; Fringe/line numbers share the main background, like doom-darkmatter
  (setq base16-theme-distinct-fringe-background nil)

  (base16-theme-define
   'darkmatter
   (list :base00 base00 :base01 base01 :base02 base02 :base03 base03
         :base04 base04 :base05 base05 :base06 base06 :base07 base07
         :base08 base08 :base09 base09 :base0A base0A :base0B base0B
         :base0C base0C :base0D base0D :base0E base0E :base0F base0F))

  ;; Where doom-darkmatter differs from stock base16 role assignments,
  ;; plus packages base16 has no faces for
  (custom-theme-set-faces
   'darkmatter
   `(cursor                      ((t (:background ,orange))))
   `(font-lock-variable-name-face ((t (:foreground ,teal))))
   `(font-lock-builtin-face      ((t (:foreground ,kw))))
   `(font-lock-constant-face     ((t (:foreground ,const))))
   `(font-lock-number-face       ((t (:foreground ,const))))
   `(font-lock-warning-face      ((t (:foreground ,orange))))
   `(mode-line                   ((t (:foreground ,fg :background ,bg :overline ,sel :box nil))))
   `(mode-line-inactive          ((t (:foreground ,dim :background ,bg :overline ,sel :box nil))))
   `(mode-line-buffer-id         ((t (:foreground ,fg :weight bold))))
   `(line-number                 ((t (:foreground ,faint :background ,bg))))
   `(line-number-current-line    ((t (:foreground ,orange :background ,bg))))
   `(vertical-border             ((t (:foreground ,sel))))
   `(erc-prompt-face             ((t (:foreground ,orange :weight bold))))
   ;; base16 uses base01 for highlight, which is ~identical to bg here
   `(highlight                   ((t (:background ,sel))))
   `(icomplete-selected-match    ((t (:foreground ,orange :background ,sel :weight bold :extend t))))
   `(completions-highlight       ((t (:inherit icomplete-selected-match))))
   ;; base16 makes this inherit gnus-group-news-6, whose default spec
   ;; inherits this face back -> cycle error in enable-theme
   `(gnus-group-news-6-empty     ((t (:foreground ,base04 :inherit outline-2))))
   ;; base16 only themes the normal 8; bright ones (used by ghostel etc.)
   ;; fall back to Emacs defaults. Match the darkmatter ghostty palette.
   `(ansi-color-bright-black     ((t (:foreground ,base03 :background ,base03))))
   `(ansi-color-bright-red       ((t (:foreground ,base08 :background ,base08))))
   `(ansi-color-bright-green     ((t (:foreground ,base0B :background ,base0B))))
   `(ansi-color-bright-yellow    ((t (:foreground ,base0A :background ,base0A))))
   `(ansi-color-bright-blue      ((t (:foreground ,base0D :background ,base0D))))
   `(ansi-color-bright-magenta   ((t (:foreground ,base0E :background ,base0E))))
   `(ansi-color-bright-cyan      ((t (:foreground ,base0C :background ,base0C))))
   `(ansi-color-bright-white     ((t (:foreground ,base07 :background ,base07))))

   ;; Packages base16 has no faces for
   `(elfeed-search-date-face          ((t (:foreground ,const))))
   `(elfeed-search-feed-face          ((t (:foreground ,func))))
   `(elfeed-search-tag-face           ((t (:foreground ,comment))))
   `(elfeed-search-title-face         ((t (:foreground ,comment))))
   `(elfeed-search-unread-title-face  ((t (:foreground ,fg :weight bold))))
   `(elfeed-search-unread-count-face  ((t (:foreground ,orange))))
   `(elfeed-search-filter-face        ((t (:foreground ,const))))
   `(elfeed-log-debug-level-face      ((t (:foreground ,comment))))
   `(elfeed-log-error-level-face      ((t (:inherit error))))
   `(elfeed-log-info-level-face       ((t (:inherit success))))
   `(elfeed-log-warn-level-face       ((t (:inherit warning))))
   `(which-key-key-face               ((t (:foreground ,orange))))
   `(which-key-group-description-face ((t (:foreground ,kw))))
   `(which-key-command-description-face ((t (:foreground ,fg)))))
  
  ;; Magit/diff/org/vc faces, flattened from doom-darkmatter
  (custom-theme-set-faces
   'darkmatter
   `(diff-hl-change ((t (:foreground "#e78a53" :background "#e78a53"))))
   `(diff-hl-delete ((t (:foreground "#aa6c6c" :background "#aa6c6c"))))
   `(diff-hl-insert ((t (:foreground "#fbcb97" :background "#fbcb97"))))
   `(diff-added ((t (:inherit hl-line :foreground ,string))))
   `(diff-changed ((t (:foreground ,const))))
   `(diff-context ((t (:foreground ,const))))
   `(diff-removed ((t (:foreground ,red :background ,sel))))
   `(diff-header ((t (:foreground ,const))))
   `(diff-file-header ((t (:foreground ,func))))
   `(diff-hunk-header ((t (:foreground ,const))))
   `(diff-indicator-added ((t (:foreground ,string))))
   `(diff-indicator-changed ((t (:foreground ,orange))))
   `(diff-indicator-removed ((t (:foreground ,red))))
   `(diff-refine-added ((t (:inherit diff-added :inverse-video t))))
   `(diff-refine-changed ((t (:inherit diff-changed :inverse-video t))))
   `(diff-refine-removed ((t (:inherit diff-removed :inverse-video t))))
   `(ediff-fine-diff-A ((t (:inherit diff-refine-removed))))
   `(ediff-fine-diff-B ((t (:inherit diff-refine-added))))
   `(ediff-fine-diff-C ((t (:inherit ediff-fine-diff-A))))
   `(ediff-current-diff-A ((t (:foreground ,red :background ,removed-bg-hi :extend t))))
   `(ediff-current-diff-B ((t (:foreground ,string :background ,added-bg-hi :extend t))))
   `(ediff-current-diff-C ((t (:inherit ediff-current-diff-A))))
   `(ediff-even-diff-A ((t (:inherit hl-line))))
   `(ediff-even-diff-B ((t (:inherit ediff-even-diff-A))))
   `(ediff-even-diff-C ((t (:inherit ediff-even-diff-A))))
   `(ediff-odd-diff-A ((t (:inherit ediff-even-diff-A))))
   `(ediff-odd-diff-B ((t (:inherit ediff-odd-diff-A))))
   `(ediff-odd-diff-C ((t (:inherit ediff-odd-diff-A))))
   `(git-commit-summary ((t (:foreground ,string))))
   `(git-commit-overlong-summary ((t (:inherit error :background ,base0 :slant italic :weight bold))))
   `(git-commit-nonempty-second-line ((t (:inherit git-commit-overlong-summary))))
   `(git-commit-keyword ((t (:foreground ,const :slant italic))))
   `(git-commit-pseudo-header ((t (:foreground ,dim :slant italic))))
   `(git-commit-known-pseudo-header ((t (:foreground ,dim :weight bold :slant italic))))
   `(git-commit-comment-branch-local ((t (:foreground ,kw))))
   `(git-commit-comment-branch-remote ((t (:foreground ,string))))
   `(git-commit-comment-detached ((t (:foreground ,orange))))
   `(git-commit-comment-heading ((t (:foreground ,kw))))
   `(git-commit-comment-file ((t (:foreground ,const))))
   `(git-commit-comment-action ((t nil)))
   `(hl-line ((t (:background ,bg :extend t))))
   `(magit-bisect-bad ((t (:foreground ,red))))
   `(magit-bisect-good ((t (:foreground ,string))))
   `(magit-bisect-skip ((t (:foreground ,orange))))
   `(magit-blame-hash ((t (:foreground ,const))))
   `(magit-blame-date ((t (:foreground ,red))))
   `(magit-blame-heading ((t (:foreground ,orange :background ,sel :extend t))))
   `(magit-branch-current ((t (:foreground ,func))))
   `(magit-branch-local ((t (:foreground ,const))))
   `(magit-branch-remote ((t (:foreground ,string))))
   `(magit-cherry-equivalent ((t (:foreground ,const))))
   `(magit-cherry-unmatched ((t (:foreground ,const))))
   `(magit-diff-added ((t (:foreground ,added-fg :background ,added-bg :extend t))))
   `(magit-diff-added-highlight ((t (:foreground ,string :background ,added-bg-hi :weight bold :extend t))))
   `(magit-diff-base ((t (:foreground ,orange-dark :background ,changed-bg :extend t))))
   `(magit-diff-base-highlight ((t (:foreground ,orange :background ,changed-bg-hi :weight bold :extend t))))
   `(magit-diff-context ((t (:foreground ,dim :background ,bg :extend t))))
   `(magit-diff-context-highlight ((t (:foreground ,fg :background ,bg :extend t))))
   `(magit-diff-file-heading ((t (:foreground ,fg :weight bold :extend t))))
   `(magit-diff-file-heading-selection ((t (:foreground ,kw :background ,dim :weight bold :extend t))))
   `(magit-diff-hunk-heading ((t (:foreground ,bg :background ,muted :extend t))))
   `(magit-diff-hunk-heading-highlight ((t (:foreground ,bg :background ,const :weight bold :extend t))))
   `(magit-diff-lines-heading ((t (:foreground ,orange :background ,red :extend t :extend t))))
   `(magit-diff-removed ((t (:foreground ,red-dark :background ,removed-bg :extend t))))
   `(magit-diff-removed-highlight ((t (:foreground ,red :background ,removed-bg-hi :weight bold :extend t))))
   `(magit-diffstat-added ((t (:foreground ,string))))
   `(magit-diffstat-removed ((t (:foreground ,red))))
   `(magit-dimmed ((t (:foreground ,kw))))
   `(magit-hash ((t (:foreground ,comment))))
   `(magit-header-line ((t (:background ,dim :foreground ,fg :weight bold :box (:line-width 3 :color ,dim)))))
   `(magit-filename ((t (:foreground ,const))))
   `(magit-log-author ((t (:foreground ,orange))))
   `(magit-log-date ((t (:foreground ,func))))
   `(magit-log-graph ((t (:foreground ,comment))))
   `(magit-process-ng ((t (:inherit error))))
   `(magit-process-ok ((t (:inherit success))))
   `(magit-reflog-amend ((t (:foreground ,kw))))
   `(magit-reflog-checkout ((t (:foreground ,func))))
   `(magit-reflog-cherry-pick ((t (:foreground ,string))))
   `(magit-reflog-commit ((t (:foreground ,string))))
   `(magit-reflog-merge ((t (:foreground ,string))))
   `(magit-reflog-other ((t (:foreground ,const))))
   `(magit-reflog-rebase ((t (:foreground ,kw))))
   `(magit-reflog-remote ((t (:foreground ,const))))
   `(magit-reflog-reset ((t (:inherit error))))
   `(magit-refname ((t (:foreground ,comment))))
   `(magit-section-heading ((t (:foreground ,func :weight bold :extend t))))
   `(magit-section-heading-selection ((t (:foreground ,orange :weight bold :extend t))))
   `(magit-section-highlight ((t (:inherit hl-line))))
   `(magit-section-secondary-heading ((t (:foreground ,const :weight bold :extend t))))
   `(magit-sequence-drop ((t (:foreground ,red))))
   `(magit-sequence-head ((t (:foreground ,func))))
   `(magit-sequence-part ((t (:foreground ,orange))))
   `(magit-sequence-stop ((t (:foreground ,string))))
   `(magit-signature-bad ((t (:inherit error))))
   `(magit-signature-error ((t (:inherit error))))
   `(magit-signature-expired ((t (:foreground ,orange))))
   `(magit-signature-good ((t (:inherit success))))
   `(magit-signature-revoked ((t (:foreground ,kw))))
   `(magit-signature-untrusted ((t (:foreground ,orange))))
   `(magit-tag ((t (:foreground ,orange))))
   `(org-block ((t (:background ,sel :extend t))))
   `(org-block-background ((t (:background ,sel :extend t))))
   `(org-block-begin-line ((t (:inherit org-block :foreground ,comment))))
   `(org-block-end-line ((t (:inherit org-block-begin-line))))
   `(org-checkbox ((t (:inherit org-todo))))
   `(org-checkbox-statistics-done ((t (:inherit org-done))))
   `(org-checkbox-statistics-todo ((t (:inherit org-todo))))
   `(org-code ((t (:inherit org-block :foreground ,orange))))
   `(org-date ((t (:foreground ,orange))))
   `(org-document-info ((t (:foreground ,kw))))
   `(org-document-title ((t (:foreground ,kw :weight bold))))
   `(org-done ((t (:inherit org-headline-done :strike-through unspecified :weight bold))))
   `(org-link ((t (:inherit link :foreground ,orange))))
   `(org-meta-line ((t (:foreground ,dim))))
   `(org-table ((t (:foreground ,const))))
   `(org-tag ((t (:foreground ,dim :weight normal))))
   `(org-todo ((t (:foreground ,string :bold inherit))))
   `(org-verbatim ((t (:foreground ,string))))
   `(outline-1 ((t (:foreground ,func :weight bold :extend t))))
   `(outline-2 ((t (:foreground ,kw :weight bold :extend t))))
   `(outline-3 ((t (:foreground ,const :weight bold :extend t))))
   `(outline-4 ((t (:foreground ,const :weight bold :extend t))))
   `(outline-5 ((t (:foreground ,const :weight bold :extend t))))
   `(outline-6 ((t (:foreground ,fg :weight bold :extend t))))
   `(outline-7 ((t (:foreground ,fg-hi :weight bold :extend t))))
   `(outline-8 ((t (:foreground ,fg-max :weight bold :extend t))))
   `(smerge-lower ((t (:background ,added-bg-hi))))
   `(smerge-upper ((t (:background ,removed-bg-hi))))
   `(smerge-base ((t (:background ,bg-tint))))
   `(smerge-markers ((t (:background ,comment :foreground ,bg :distant-foreground ,fg :weight bold))))
   `(smerge-refined-added ((t (:inherit diff-added :inverse-video t))))
   `(smerge-refined-removed ((t (:inherit diff-removed :inverse-video t))))
   `(smerge-mine ((t (:background ,removed-bg-hi))))
   `(smerge-other ((t (:background ,added-bg-hi))))))

(provide-theme 'darkmatter)

;;; darkmatter-theme.el ends here
