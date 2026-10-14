;;; init-tools.el -*- lexical-binding: t; -*-

(use-package magit
  :defer t)

(use-package diff-hl
  :hook ((after-init . global-diff-hl-mode)
         (dired-mode . diff-hl-dired-mode)
         (magit-pre-refresh . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :custom
  (diff-hl-margin-symbols-alist
   '((insert . "+") (delete . "-") (change . "~")
     (unknown . "?") (ignored . "i") (reference . " ")))
  (diff-hl-draw-borders nil)
  :config
  (diff-hl-flydiff-mode 1)
  (diff-hl-margin-mode 1)
  ;; base16-theme already defines these faces, so the theme file can't
  ;; override them; set them here instead.
  (custom-set-faces
   '(diff-hl-insert ((t (:foreground "#fbcb97" :background "#fbcb97"))))
   '(diff-hl-change ((t (:foreground "#e78a53" :background "#e78a53"))))
   '(diff-hl-delete ((t (:foreground "#aa6c6c" :background "#aa6c6c"))))
   ;; margin text: color the symbol only, no filled background
   '(diff-hl-margin-insert ((t (:foreground "#fbcb97" :background unspecified :weight bold))))
   '(diff-hl-margin-change ((t (:foreground "#e78a53" :background unspecified :weight bold))))
   '(diff-hl-margin-delete ((t (:foreground "#aa6c6c" :background unspecified :weight bold))))))

(use-package elfeed
  :defer t
  :config
  (setq-default elfeed-search-filter "@6-months-ago")

  (defvar my/elfeed-feeds-url "https://feeds.stevedylan.dev/feeds?format=json"
    "Endpoint returning my subscriptions as JSON.")

  (defun my/elfeed-refresh-feeds ()
    "Replace `elfeed-feeds' with the list from `my/elfeed-feeds-url'.
Keeps the current list if the fetch fails."
    (interactive)
    (condition-case err
        (let ((buf (url-retrieve-synchronously my/elfeed-feeds-url t t 10)))
          (unless buf (error "no response"))
          (with-current-buffer buf
            (goto-char (point-min))
            (re-search-forward "\n\n")
            (let* ((data (json-parse-buffer :object-type 'alist :array-type 'list))
                   (urls (mapcar (lambda (s) (alist-get 'url s))
                                 (alist-get 'subscriptions data))))
              (kill-buffer buf)
              (setq elfeed-feeds urls)
              (message "elfeed: loaded %d feeds" (length urls)))))
      (error (message "elfeed: feed refresh failed (%s), keeping existing list"
                      (error-message-string err)))))

  (advice-add 'elfeed-update :before #'my/elfeed-refresh-feeds)

  (defun my/elfeed-show-font ()
    (face-remap-add-relative 'variable-pitch :family "BerkeleyMono Nerd Font Mono" :height 140)
    (face-remap-add-relative 'default :family "BerkeleyMono Nerd Font Mono" :height 140))
  (add-hook 'elfeed-show-mode-hook #'my/elfeed-show-font))

(use-package ob-go
  :defer t)

(use-package org
  :ensure nil
  :defer t
  :config
  (require 'ob-go)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((js    . t)
     (shell . t)
     (go    . t)))

  (setq org-directory "~/org/"
        org-default-notes-file (expand-file-name "inbox.org" org-directory)
        org-capture-templates
        '(("t" "Todo" entry (file+headline "inbox.org" "Tasks")
           "* TODO %?\n%i\n%a" :empty-lines 1)
          ("n" "Note" entry (file+headline "inbox.org" "Notes")
           "* %?\n%U\n%i" :empty-lines 1)
          ("j" "Journal" entry (file+olp+datetree "journal.org")
           "* %U %?\n%i" :empty-lines 1)
          ("b" "Bookmark" entry (file "bookmarks.org")
           "* [[%^{URL}][%^{Title}]] %^g\n:PROPERTIES:\n:ADDED: %U\n:END:\n%?"
           :empty-lines 1))))

(use-package dired
  :ensure nil
  :custom
  (dired-kill-when-opening-new-dired-buffer t)  ; reuse one buffer
  (dired-dwim-target t)
  :hook (dired-mode . dired-omit-mode)          ; hide dotfiles by default
  :config
  (require 'dired-x)
  (setq dired-omit-files "\\`[.][^.]")          ; dotfiles, but keep ".."
  (evil-collection-define-key 'normal 'dired-mode-map
    "." 'dired-omit-mode                        ; toggle dotfiles
    "h" 'dired-up-directory
    "l" 'dired-find-file
    "q" 'quit-window))

(autoload 'posts-compose "posts" nil t)
(autoload 'uguu-upload-file "uguu" nil t)
(autoload 'uguu-upload-clipboard "uguu" nil t)

(defgroup openrouter nil
  "OpenRouter backend for gptel."
  :group 'gptel)

(defcustom openrouter-pass-entry "openrouter/openrouter-api-key"
  "Name of the `pass' entry holding the API key."
  :type 'string
  :group 'openrouter)

(defun openrouter--api-key ()
  "Return the OpenRouter API key from password-store."
  (require 'auth-source-pass)       ; autoloaded in Emacs 28+, but cheap to be explicit
  (let ((key (auth-source-pass-get 'secret openrouter-pass-entry)))
    (or (and key (string-trim key))
        (user-error "No pass entry `%s'" openrouter-pass-entry))))

(use-package gptel
  :defer t
  :config
  (setq gptel-backend
        (gptel-make-openai "OpenRouter"
          :host "openrouter.ai"
          :endpoint "/api/v1/chat/completions"
          :stream t
          :key #'openrouter--api-key
          :request-params '(:tools [(:type "openrouter:web_search")
                                    (:type "openrouter:web_fetch")])
          :models '(z-ai/glm-5.3
                    z-ai/glm-5.3-flash
                    z-ai/glm-5.3-flashx))))

(defun gptel-model (model)
  "Set the gptel model in the current buffer."
  (interactive
   (list (intern (completing-read "Model: "
                                  '("z-ai/glm-5.3"
                                    "z-ai/glm-5.3-flash"
                                    "z-ai/glm-5.3-flashx")))))
  (setq-local gptel-model model))

(use-package markdown-mode
  :defer t)


(provide 'init-tools)
