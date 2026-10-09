;;; init-tools.el -*- lexical-binding: t; -*-

(use-package magit)

(use-package elfeed)

;; Feeds live in ~/org/elfeed.org, same as the Doom setup
(use-package elfeed-org
  :after elfeed
  :config
  (setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
  (elfeed-org))

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
