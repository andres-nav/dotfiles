;; init-evil.el --- Initialize evil configurations

;;; Commentary:

;;; Code:

(use-package evil
  :diminish
  :hook (after-init . evil-mode)
  :init
  (setq evil-want-keybinding nil
	      evil-want-C-u-scroll t
	      evil-undo-system 'undo-fu)

  (defadvice evil-window-split (after move-point-to-new-window activate)
    (other-window 1))

  (defadvice evil-window-vsplit (after move-point-to-new-window activate)
    (other-window 1)))

(use-package evil-collection
  :diminish
  :after evil
  :config
  (evil-collection-init)
  (evil-collection-swap-key nil 'evil-motion-state-map ";" ":")
  )

(use-package evil-surround
  :diminish
  :after evil-collection
  :hook (after-init . global-evil-surround-mode))

(provide 'init-evil)

;;; init-evil.el ends here
