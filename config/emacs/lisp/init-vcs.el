;; init-vcs.el --- Initialize version control system configurations

;;; Commentary:

;;; Code:

;; Git
;; TODO: add flyspell <https://github.com/condy0919/.emacs.d/blob/336f30dccd03f3e7b6c07d22c71d61aa26d61351/lisp/init-git.el>
(use-package magit
  :diminish
  :hook
  (git-commit-mode . evil-insert-state)
  (after-save . magit-after-save-refresh-status)
  :custom
  (magit-diff-refine-hunk t)
  (magit-diff-paint-whitespace nil)
  (magit-ediff-dwim-show-on-hunks t)
  )

(use-package forge
  :diminish
  :after magit)

;; NOTE: `diff-hl' depends on `vc'
(use-package vc
  :ensure nil
  :custom
  (vc-follow-symlinks t)
  (vc-allow-async-revert t)
  (vc-handled-backends '(Git)))

;; Highlight uncommitted changes using VC
(use-package diff-hl
  :hook (
         (dired-mode         . diff-hl-dired-mode-unless-remote)
         (magit-pre-refresh  . diff-hl-magit-pre-refresh)
         (magit-post-refresh . diff-hl-magit-post-refresh))
  :config
  ;; When Emacs runs in terminal, show the indicators in margin instead.
  ;; (unless (display-graphic-p)
  ;;   (diff-hl-margin-mode))
  )

;; Git configuration modes
(use-package git-modes
  :diminish)

;; TODO: add git-time-machine

(provide 'init-vcs)

;;; init-vcs.el ends here
