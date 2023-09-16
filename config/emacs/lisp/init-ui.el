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
;; (use-package telephone-line
;;   :hook (after-init . telephone-line-mode)
;;   :config
;;   (setq telephone-line-primary-left-separator 'telephone-line-gradient
;; 	telephone-line-secondary-left-separator 'telephone-line-nil
;; 	telephone-line-primary-right-separator 'telephone-line-gradient
;; 	telephone-line-secondary-right-separator 'telephone-line-nil)
;;   (setq telephone-line-height 12
;; 	telephone-line-evil-use-short-tag t)
;;   (defface telephone-line-evil-char
;; 	'((t (:background "forest green" :inherit telephone-line-evil)))
;; 	"Face used in evil color-coded segments when in Char state."
;; 	:group 'telephone-line-evil)
;;   (defface telephone-line-evil-word
;; 	'((t (:background "#5E81AC" :inherit telephone-line-evil)))
;; 	"Face used in evil color-cioded segments when in Normal state."
;; 	:group 'telephone-line-evil)
;;   (add-to-list 'telephone-line-faces
;; 		'(evil . (telephone-line-evil-word . telephone-line-evil-char)))
;; )

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-minor-modes t)
  )

;; Hide mode line for some modes
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
      inhibit-x-resources t
      inhibit-startup-screen t
      inhibit-startup-message t
      inhibit-startup-buffer-menu t
      inhibit-startup-echo-area-message user-login-name
      inhibit-default-init t
      initial-scratch-message nil)

;; Pixelwise resize
(setq window-resize-pixelwise t
      frame-resize-pixelwise t)

;; Linux specific
(setq x-gtk-use-system-tooltips nil
      x-gtk-use-native-input t
      x-underline-at-descent-line t)

;; With GPG 2.1+, this forces gpg-agent to use the Emacs minibuffer to prompt
;; for the key passphrase.
(setq epg-pinentry-mode 'loopback)

;; Optimize for very long lines
(setq-default bidi-paragraph-direction 'left-to-right)
(setq bidi-inhibit-bpa t)

;; Display dividers between windows
(setq window-divider-default-places t
      window-divider-default-bottom-width 1
      window-divider-default-right-width 1)
(add-hook 'window-setup-hook #'window-divider-mode)

;; Font
(add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font Mono 10"))

;; Highlight parenthesises
(use-package paren
  :ensure nil
  :hook (after-init . show-paren-mode)
  :custom
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t)
  (show-paren-context-when-offscreen t)
  )

;; Type text
(use-package text-mode
  :ensure nil
  :custom
  ;; better word wrapping for CJK characters
  (word-wrap-by-category t)
  ;; paragraphs
  (sentence-end-double-space nil))

(provide 'init-ui)

;;; init-ui.el ends here
