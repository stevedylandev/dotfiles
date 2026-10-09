;;; init-ui.el -*- lexical-binding: t; -*-

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "BerkeleyMono Nerd Font" :height 140))

(use-package base16-theme)

(load-theme 'darkmatter t)

;;; Mode line
;; Evil's own indicator is dropped; the state is drawn by hand as a colored
;; square with the state letter. Icons are Nerd Font glyphs.
(setq evil-mode-line-format nil
      evil-echo-state nil)   ; no "-- INSERT --" in the echo area
(column-number-mode 1)

(defvar my/ml-states
  `((normal   "N" ,(alist-get 'base08 darkmatter-palette))
    (insert   "I" ,(alist-get 'base0A darkmatter-palette))
    (visual   "V" ,(alist-get 'base0B darkmatter-palette))
    (replace  "R" ,(alist-get 'red darkmatter-palette))
    (operator "O" ,(alist-get 'base0D darkmatter-palette))
    (motion   "M" ,(alist-get 'base0D darkmatter-palette))
    (emacs    "E" ,(alist-get 'base09 darkmatter-palette)))
  "Evil state -> (letter color) for the mode line.")

(defun my/ml-evil-state ()
  "Colored square with the current evil state letter."
  (when (bound-and-true-p evil-local-mode)
    (pcase-let ((`(,letter ,color) (or (alist-get evil-state my/ml-states)
                                       '("?" "#666666"))))
      (propertize (format " %s " letter)
                  'face `(:background ,color
                          :foreground ,(alist-get 'base00 darkmatter-palette)
                          :weight bold)))))

(setq-default
 mode-line-format
 '("%e"
   (:eval (my/ml-evil-state))
   "  "
   (:eval (when (and buffer-file-name (buffer-modified-p))
            (propertize "\uf111 " 'face '(:foreground "#e78a53"))))   ; nf-fa-circle
   (:propertize "%b" face mode-line-buffer-id)
   (:eval (when buffer-read-only "  \uf023"))                        ; nf-fa-lock
   "  "
   mode-name
   (:eval (when vc-mode
            (concat "  \ue0a0 "                                      ; branch
                    (string-trim (replace-regexp-in-string "^ *Git[-:]" "" vc-mode)))))
   mode-line-format-right-align
   ;; ERC / jabber activity ([#chan,...]) lives here
   (:eval (when (string-match-p "[^ ]" (format-mode-line global-mode-string))
            global-mode-string))
   "  %l:%c  %p "))

(setq initial-scratch-message
      " .              +   .                .   . .     .  .
                   .                    .       .     *
  .       *                        . . . .  .   .  + .
            \"You Are Here\"            .   .  +  . . .
.                 |             .  .   .    .    . .
                  |           .     .     . +.    +  .
                 \\|/            .       .   . .
        . .       V          .    * . . .  .  +   .
           +      .           .   .      +
                            .       . +  .+. .
  .                      .     . + .  . .     .      .
           .      .    .     . .   . . .        ! /
      *             .    . .  +    .  .       - O -
          .     .    .  +   . .  *  .       . / |
               . + .  .  .  .. +  .
.      .  .  .  *   .  *  . +..  .            *
 .      .   . .   .   .   . .  +   .    .            +

")

(provide 'init-ui)
