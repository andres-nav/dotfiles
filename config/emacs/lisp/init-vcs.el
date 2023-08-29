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

;; Git gutter
;; (use-package git-gutter
;;   :diminish
;;   :after evil
;;   :hook
;;   (prog-mode . git-gutter-mode)
;;   :custom
;;   (git-gutter:verbosity 0) ;; Remove log messages
;;   (git-gutter:update-timer 2) 
;;   :init
;;   ;; FIXME: make proper use of hooks
;;   (add-to-list 'git-gutter:update-hooks 'evil-normal-state-entry-hook)
;;   )

;; TODO: add git-time-machine

(provide 'init-vcs)

;;; init-vcs.el ends here
