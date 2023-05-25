(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(setq inhibit-startup-message t
      visible-bell t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(save-place-mode 1) ;; save cursor place
(savehist-mode 1) ;; save history of minibuffer
(global-auto-revert-mode 1) ;; auto refresh buffers that have been changed on disk

(global-display-line-numbers-mode 1)

(setq use-dialog-box nil ;; remove annoying dialog boxes
      enable-recursive-minibuffers t) ;; enable recursive minibuffers

(auto-save-visited-mode 1) ;; makes autosaves save to current file

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all) ;; hook to autosave when loosing focus

(setq backup-directory-alist
  `(("." . ,(concat user-emacs-directory "backups"))))

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

(use-package dracula-theme
  :init
  (load-theme 'dracula t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package magit
  :ensure t)

(use-package projectile
  :ensure t
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
    ("s-p" . projectile-command-map)))

(use-package vterm
  :ensure t)

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic) ;; check consult wiki to tweak
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; TODO add undo-fu-session

(use-package tree-sitter ;; remove for emacs 29
  :ensure t
  :init
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs ;; remove for emacs 29
  :ensure t)

(use-package nix-mode
  :mode "\\.nix\\'")


