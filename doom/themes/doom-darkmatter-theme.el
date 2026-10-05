;;; doom-darkmatter-theme.el -*- lexical-binding: t; -*-

;;; doom-darkmatter-theme.el --- Darkmatter for Doom -*- lexical-binding: t; -*-
(require 'doom-themes)

(def-doom-theme doom-darkmatter
  "Darkmatter (https://darkmattertheme.com), based on Black Metal Bathory."

  ;; name        default   256       16
  ((bg         '("#121113" nil       nil))
   (bg-alt     '("#121113" nil       nil))
   (base0      '("#0b0a0b" "black"   "black"))
   (base1      '("#121212" "#1c1c1c" "brightblack"))
   (base2      '("#1a191a" "#262626" "brightblack"))
   (base3      '("#222222" "#303030" "brightblack"))
   (base4      '("#333333" "#444444" "brightblack"))
   (base5      '("#555555" "#585858" "brightblack"))
   (base6      '("#777777" "#767676" "brightblack"))
   (base7      '("#999999" "#9e9e9e" "brightblack"))
   (base8      '("#c1c1c1" "#bcbcbc" "white"))
   (fg         '("#c1c1c1" "#bcbcbc" "white"))
   (fg-alt     '("#999999" "#9e9e9e" "brightwhite"))

   (grey       base5)          ; comments; Darkmatter's #333333 is very dim, see note
   (red        '("#aa6c6c" "#af5f5f" "red"))   ; added for errors
   (orange     '("#e78a53" "#d7875f" "brightred"))
   (green      '("#fbcb97" "#ffd7af" "green"))  ; strings
   (teal       '("#5f8787" "#5f8787" "brightgreen"))
   (yellow     '("#e78a53" "#d7875f" "yellow"))
   (blue       '("#888888" "#878787" "brightblue"))
   (dark-blue  '("#666666" "#626262" "blue"))
   (magenta    '("#999999" "#9e9e9e" "brightmagenta"))
   (violet     '("#aaaaaa" "#a8a8a8" "magenta"))
   (cyan       '("#aaaaaa" "#a8a8a8" "brightcyan"))
   (dark-cyan  '("#5f8787" "#5f8787" "cyan"))

   ;; semantic roles
   (highlight      orange)
   (vertical-bar   base3)
   (selection      base3)
   (builtin        magenta)
   (comments       base5)
   (doc-comments   base6)
   (constants      violet)
   (functions      blue)
   (keywords       magenta)
   (methods        blue)
   (operators      fg-alt)
   (type           orange)
   (strings        green)
   (variables      teal)
   (numbers        violet)
   (region         base3)
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; modeline
   (modeline-fg     fg)
   (modeline-fg-alt base6)
   (modeline-bg     bg)
   (modeline-bg-inactive bg-alt))

  ;; extra face tweaks
  (((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground orange)
   (mode-line :background modeline-bg :foreground modeline-fg)
   (mode-line-inactive :background modeline-bg-inactive :foreground modeline-fg-alt)))

;;; doom-darkmatter-theme.el ends here
