;; init-vcs.el --- Initialize version control system configurations

;;; Commentary:

;;; Code:

;; Git
(use-package magit
  :diminish
  :hook
  (git-commit-mode . evil-insert-state)
  (after-save . magit-after-save-refresh-status)
  :config
  )

(use-package forge
  :diminish
  :after magit)

;; Git configuration modes
(use-package git-modes
  :diminish)

(provide 'init-vcs)

;;; init-vcs.el ends here
