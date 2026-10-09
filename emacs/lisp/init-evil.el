;;; init-evil.el -*- lexical-binding: t; -*-

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil   ; evil-collection handles other modes
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-undo-system 'undo-redo
        evil-split-window-below t
        evil-vsplit-window-right t
        evil-ex-hl-update-delay 0.01)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual motion insert emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (my/leader
    "SPC" '(project-find-file :wk "project file")
    ":"   '(execute-extended-command :wk "M-x")
    "."   '(find-file :wk "find file")
    ","   '(switch-to-buffer :wk "switch buffer")
    "/"   '(project-find-regexp :wk "project grep")

    "X"   '(org-capture :wk "org capture")

    "b"   '(:ignore t :wk "buffer")
    "bb"  '(switch-to-buffer :wk "switch")
    "bi"  '(ibuffer :wk "ibuffer")
    "bd"  '(kill-current-buffer :wk "kill")
    "bn"  '(next-buffer :wk "next")
    "bp"  '(previous-buffer :wk "previous")
    "bs"  '(save-buffer :wk "save")

    "f"   '(:ignore t :wk "file")
    "ff"  '(find-file :wk "find")
    "fr"  '(recentf-open :wk "recent")
    "fs"  '(save-buffer :wk "save")
    "fd"  '(dired-jump :wk "dired")

    "g"   '(:ignore t :wk "git")
    "gg"  '(magit-status :wk "status")
    "gb"  '(magit-blame :wk "blame")
    "gl"  '(magit-log-current :wk "log")

    "o"   '(:ignore t :wk "open")
    "ow"  '(eww :wk "eww")
    "oe"  '(elfeed :wk "elfeed")
    "oi"  '(my/erc-soju :wk "irc")
    "oj"  '(jabber-roster :wk "jabber")
    "om"  '(mu4e :wk "mail")
    "ot"  '(ghostel :wk "terminal")
    "oT"  '(ghostel-project :wk "project terminal")
    "os"  '(eshell :wk "eshell")

    "u"   '(:ignore t :wk "upload")
    "uu"  '(uguu-upload-file :wk "upload file")
    "uc"  '(uguu-upload-clipboard :wk "upload clipboard")

    "P"   '(posts-compose :wk "new post")

    "p"   '(:ignore t :wk "project")
    "pp"  '(project-switch-project :wk "switch")
    "pf"  '(project-find-file :wk "find file")
    "pg"  '(project-find-regexp :wk "grep")
    "pb"  '(project-switch-to-buffer :wk "buffer")

    "s"   '(:ignore t :wk "search")
    "ss"  '(isearch-forward :wk "isearch")
    "so"  '(occur :wk "occur")

    "w"   '(:ignore t :wk "window")
    "ww"  '(other-window :wk "other")
    "wv"  '(evil-window-vsplit :wk "vsplit")
    "ws"  '(evil-window-split :wk "split")
    "wd"  '(delete-window :wk "close")
    "wo"  '(delete-other-windows :wk "only")
    "wh"  '(evil-window-left :wk "left")
    "wj"  '(evil-window-down :wk "down")
    "wk"  '(evil-window-up :wk "up")
    "wl"  '(evil-window-right :wk "right")
    "w="  '(balance-windows :wk "balance")

    "h"   '(:ignore t :wk "help")
    "hf"  '(describe-function :wk "function")
    "hv"  '(describe-variable :wk "variable")
    "hk"  '(describe-key :wk "key")
    "hm"  '(describe-mode :wk "mode")

    "q"   '(:ignore t :wk "quit")
    "qq"  '(save-buffers-kill-terminal :wk "quit emacs")))

(provide 'init-evil)
