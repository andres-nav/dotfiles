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
      enable-recursive-minibuffers t ;; enable recursive minibuffers
      initial-major-mode 'org-mode) ;; set the scratch buffer mode to org

(set-frame-font "FiraCode Nerd Font-10" nil t) ;; set default font

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
  :config
  (load-theme 'dracula t))

(use-package evil
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-undo-system 'undo-fu)

  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package magit) ;; add forge, github-review, magit gitflow, magit todos

(use-package projectile
  :config
  (projectile-mode +1)
  :bind (:map projectile-mode-map
    ("s-p" . projectile-command-map)))

(use-package vterm)

(use-package vertico
  :config
  (vertico-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic) ;; check consult wiki to tweak
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; TODO consult, evil-terminal-cursor-changer, clipetty
(use-package undo-fu
  :ensure t
  :init
  (setq undo-limit 67108864 ; 64mb
	undo-strong-limit 100663296 ; 96mb
        undo-outer-limit 1006632960)) ; 960mb

(use-package undo-fu-session
  :ensure t
  :after undo-fu
  :init
  (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))
  :config
  (undo-fu-session-global-mode))

(use-package tree-sitter ;; remove for emacs 29
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs) ;; remove for emacs 29

(use-package nix-mode
  :mode "\\.nix\\'")


 (use-package ess
  :ensure t
  :init (require 'ess-site))
