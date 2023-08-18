;; init-evil.el --- Initialize evil configurations

;;; Commentary:

;;; Code:

(use-package evil
  :diminish
  :hook (after-init . evil-mode)
  (after-save . evil-normal-state)
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-want-Y-yank-to-eol t
	evil-shift-width 2
	evil-esc-delay 0
	evil-echo-state nil
	evil-undo-system 'undo-fu)

  (defadvice evil-window-split (after move-point-to-new-window activate)
    (other-window 1))

  (defadvice evil-window-vsplit (after move-point-to-new-window activate)
    (other-window 1))
  )

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (evil-collection-swap-key nil 'evil-motion-state-map ";" ":")
  :init (evil-collection-init)
  )

(use-package evil-surround
  :diminish
  :after evil-collection
  :hook (evil-mode . global-evil-surround-mode))

;; TODO: install evil-indent-plus

;; TODO: install evil-easymotion

(use-package evil-commentary
  :diminish
  :after evil-collection
  :hook (evil-mode . evil-commentary-mode))

;; Package to align characters
(use-package evil-lion
  :diminish
  :after evil-collection
  :hook (evil-mode . evil-lion-mode))

(provide 'init-evil)

;;; init-evil.el ends here
