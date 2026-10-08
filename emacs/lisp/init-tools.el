;;; init-tools.el -*- lexical-binding: t; -*-

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package elfeed
  :bind ("C-x w" . elfeed))

;; Feeds live in ~/org/elfeed.org, same as the Doom setup
(use-package elfeed-org
  :after elfeed
  :config
  (setq rmh-elfeed-org-files (list "~/org/elfeed.org"))
  (elfeed-org))

(provide 'init-tools)
