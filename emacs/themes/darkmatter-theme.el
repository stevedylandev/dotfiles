;;; darkmatter-theme.el --- Darkmatter -*- lexical-binding: t; -*-

;; Standalone port of the doom-darkmatter theme (no doom-themes needed).
;; https://darkmattertheme.com

(deftheme darkmatter "Darkmatter, based on Black Metal Bathory.")

(let* ((bg      "#121113")
       (base0   "#0b0a0b")
       (base2   "#1a191a")
       (base3   "#222222")
       (base4   "#333333")
       (base5   "#555555")
       (base6   "#777777")
       (base7   "#999999")
       (fg      "#c1c1c1")
       (fg-alt  "#999999")
       (red     "#aa6c6c")
       (orange  "#e78a53")
       (string  "#fbcb97")
       (teal    "#5f8787")
       (blue    "#888888")
       (violet  "#aaaaaa"))
  (custom-theme-set-faces
   'darkmatter
   `(default ((t (:background ,bg :foreground ,fg))))
   `(cursor ((t (:background ,orange))))
   `(fringe ((t (:background ,bg :foreground ,base4))))
   `(region ((t (:background ,base3 :extend t))))
   `(highlight ((t (:background ,base3))))
   `(hl-line ((t (:background ,base2))))
   `(secondary-selection ((t (:background ,base3))))
   `(shadow ((t (:foreground ,base6))))
   `(link ((t (:foreground ,orange :underline t))))
   `(link-visited ((t (:foreground ,base7 :underline t))))
   `(match ((t (:foreground ,orange :weight bold))))
   `(isearch ((t (:background ,orange :foreground ,bg :weight bold))))
   `(lazy-highlight ((t (:background ,base4 :foreground ,fg))))
   `(error ((t (:foreground ,red))))
   `(warning ((t (:foreground ,orange))))
   `(success ((t (:foreground ,string))))
   `(escape-glyph ((t (:foreground ,orange))))
   `(minibuffer-prompt ((t (:foreground ,orange))))
   `(vertical-border ((t (:foreground ,base3))))
   `(window-divider ((t (:foreground ,base3))))
   `(show-paren-match ((t (:foreground ,orange :weight bold :underline t))))
   `(show-paren-mismatch ((t (:background ,red :foreground ,bg))))
   `(trailing-whitespace ((t (:background ,base4))))

   ;; line numbers
   `(line-number ((t (:foreground ,base4 :background ,bg))))
   `(line-number-current-line ((t (:foreground ,orange :background ,bg))))

   ;; mode line
   `(mode-line ((t (:background ,bg :foreground ,fg :box nil :overline ,base3))))
   `(mode-line-inactive ((t (:background ,bg :foreground ,base6 :box nil :overline ,base3))))
   `(mode-line-emphasis ((t (:foreground ,orange))))
   `(mode-line-buffer-id ((t (:weight bold))))
   `(header-line ((t (:background ,bg :foreground ,fg-alt))))

   ;; syntax
   `(font-lock-builtin-face ((t (:foreground ,base7))))
   `(font-lock-comment-face ((t (:foreground ,base5))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,base5))))
   `(font-lock-doc-face ((t (:foreground ,base6))))
   `(font-lock-constant-face ((t (:foreground ,violet))))
   `(font-lock-function-name-face ((t (:foreground ,blue))))
   `(font-lock-keyword-face ((t (:foreground ,base7))))
   `(font-lock-negation-char-face ((t (:foreground ,fg-alt))))
   `(font-lock-preprocessor-face ((t (:foreground ,base7))))
   `(font-lock-string-face ((t (:foreground ,string))))
   `(font-lock-type-face ((t (:foreground ,orange))))
   `(font-lock-variable-name-face ((t (:foreground ,teal))))
   `(font-lock-warning-face ((t (:foreground ,orange))))

   ;; completion
   `(completions-common-part ((t (:foreground ,orange))))
   `(completions-first-difference ((t (:foreground ,fg :weight bold))))
   `(completions-annotations ((t (:foreground ,base6))))

   ;; org
   `(org-level-1 ((t (:foreground ,orange :weight bold))))
   `(org-level-2 ((t (:foreground ,string))))
   `(org-level-3 ((t (:foreground ,teal))))
   `(org-level-4 ((t (:foreground ,violet))))
   `(org-code ((t (:foreground ,string))))
   `(org-verbatim ((t (:foreground ,teal))))
   `(org-block ((t (:background ,base2 :extend t))))
   `(org-todo ((t (:foreground ,orange :weight bold))))
   `(org-done ((t (:foreground ,base6 :weight bold))))

   ;; diff / vc
   `(diff-added ((t (:foreground ,string))))
   `(diff-removed ((t (:foreground ,red))))
   `(diff-changed ((t (:foreground ,orange))))

   ;; ERC
   `(erc-default-face ((t (:foreground ,fg))))
   `(erc-timestamp-face ((t (:foreground ,base5))))
   `(erc-prompt-face ((t (:foreground ,orange :weight bold))))
   `(erc-notice-face ((t (:foreground ,base6))))
   `(erc-input-face ((t (:foreground ,string))))
   `(erc-my-nick-face ((t (:foreground ,orange :weight bold))))
   `(erc-nick-default-face ((t (:foreground ,teal :weight bold))))
   `(erc-nick-msg-face ((t (:foreground ,orange))))
   `(erc-direct-msg-face ((t (:foreground ,orange))))
   `(erc-action-face ((t (:foreground ,violet :slant italic))))
   `(erc-error-face ((t (:foreground ,red))))
   `(erc-current-nick-face ((t (:foreground ,orange :weight bold))))
   `(erc-keyword-face ((t (:foreground ,orange :weight bold))))
   `(erc-pal-face ((t (:foreground ,string :weight bold))))
   `(erc-fool-face ((t (:foreground ,base5))))
   `(erc-header-line ((t (:background ,bg :foreground ,fg-alt))))
   `(erc-button ((t (:foreground ,orange :underline t))))
   `(erc-bold-face ((t (:weight bold))))
   `(erc-underline-face ((t (:underline t))))
   `(erc-command-indicator-face ((t (:foreground ,base7 :weight bold))))
   `(erc-fill-wrap-merge-indicator-face ((t (:foreground ,base4))))))

(provide-theme 'darkmatter)

;;; darkmatter-theme.el ends here
