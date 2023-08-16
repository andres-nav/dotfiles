;; init-dired.el --- Initialize dired configurations

;;; Commentary:

;;; Code:

(use-package dired
  :ensure nil
  :after evil
  :config
  ;; Always delete and copy recursively
  (setq dired-recursive-deletes 'always
        dired-recursive-copies 'always)

  ;; Show directory first
  (setq dired-listing-switches "-alh --group-directories-first")

  ;; evil keybindings for dired
  (evil-define-key 'normal dired-mode-map
    "h" 'dired-jump)
  (evil-define-key 'normal dired-mode-map
    "l" 'dired-find-alternate-file)

  ;; Colorful dired
  (use-package diredfl
    :hook (dired-mode . diredfl-mode))

  ;; `find-dired' alternative using `fd'
  (when (executable-find "fd")
    (use-package fd-dired))

  ;; Hide hidden files
  (use-package dired-hide-dotfiles
    :ensure t
    :hook
    (dired-mode . dired-hide-dotfiles-mode)
    :config

    (evil-define-key 'normal dired-mode-map
      "." 'dired-hide-dotfiles-mode)
    )

  ;; Extra Dired functionality
  (use-package dired-aux :ensure nil)
  )


(provide 'init-dired)

;;; init-dired.el ends here
