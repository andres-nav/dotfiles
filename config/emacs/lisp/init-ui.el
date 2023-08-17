;; init-ui.el --- Better lookings and appearances

;;; Commentary:

;;; Code:

;; Optimization
(setq idle-update-delay 1.0)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)

(setq fast-but-imprecise-scrolling t)
(setq redisplay-skip-fontification-on-input t)

;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t
      frame-resize-pixelwise t)

;; Theme
(use-package dracula-theme
  :init
  (load-theme 'dracula t))

;; Mode-line
(use-package telephone-line
  :hook (after-init . telephone-line-mode)
  :config
  (setq telephone-line-primary-left-separator 'telephone-line-gradient
	telephone-line-secondary-left-separator 'telephone-line-nil
	telephone-line-primary-right-separator 'telephone-line-gradient
	telephone-line-secondary-right-separator 'telephone-line-nil)
  (setq telephone-line-height 12
	telephone-line-evil-use-short-tag t)
)

(use-package hide-mode-line
  :diminish
  :hook ((help-mode
	  treemacs-mode
	  eshell-mode shell-mode
	  term-mode vterm-mode) . hide-mode-line-mode)
  )

;; Show line numbers
(use-package display-line-numbers
  :ensure nil
  :hook ((prog-mode yaml-mode conf-mode markdown-mode) . display-line-numbers-mode)
  :init (setq display-line-numbers-width-start t))

;; Suppress GUI features
(setq use-file-dialog nil
      use-dialog-box nil
      inhibit-startup-screen t
      inhibit-startup-echo-area-message user-login-name
      inhibit-default-init t
      initial-scratch-message nil)

;; Display dividers between windows
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; Font
(add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font Mono 10"))

(provide 'init-ui)

;;; init-ui.el ends here
