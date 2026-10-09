;;; init-tools.el -*- lexical-binding: t; -*-

(use-package magit)

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
  :config
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

  ;; Fresh list before every update (`G' / `elfeed-update')
  (advice-add 'elfeed-update :before #'my/elfeed-refresh-feeds))

;; ob-go isn't bundled with org; must load before org-babel-do-load-languages
(use-package ob-go)

(use-package org
  :ensure nil
  :config
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

(require 'posts)
(require 'uguu)

(provide 'init-tools)
