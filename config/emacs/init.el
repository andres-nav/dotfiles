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

;; Performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb

(add-hook 'after-init-hook #'(lambda ()
                               ;; restore after startup
                               (setq gc-cons-threshold 800000)))

(add-hook 'focus-out-hook #'garbage-collect)

;; Basic defaults
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(save-place-mode 1) ;; save cursor place
(savehist-mode 1) ;; save history of minibuffer
(global-auto-revert-mode 1) ;; auto refresh buffers that have been changed on disk
(electric-pair-mode 1) ;; auto fill brackets

(setq inhibit-startup-message t
      visible-bell t
      use-dialog-box nil ;; remove annoying dialog boxes
      enable-recursive-minibuffers t ;; enable recursive minibuffers
      initial-major-mode 'org-mode ;; set the scratch buffer mode to org
      initial-scratch-message ""
      )

(fset 'yes-or-no-p 'y-or-n-p) ;; change yes or no to y or n

(add-to-list 'default-frame-alist '(font . "CaskaydiaCove Nerd Font Mono 10"))

(add-hook 'prog-mode-hook                 ; Show line numbers in programming modes
          (if (and (fboundp 'display-line-numbers-mode) (display-graphic-p))
              #'display-line-numbers-mode
            #'linum-mode))


(auto-save-visited-mode 1) ;; makes autosaves save to current file

(defun save-all ()
  (interactive)
  (save-some-buffers t))

(add-hook 'focus-out-hook 'save-all) ;; hook to autosave when loosing focus

;; Separate custom vars into another file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;;; Put Emacs auto-save and backup files to /tmp/ or C:/Temp/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq
   backup-by-copying t                                        ; Avoid symlinks
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t
   auto-save-list-file-prefix emacs-tmp-dir
   auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))  ; Change autosave dir to tmp
   backup-directory-alist `((".*" . ,emacs-tmp-dir)))

;;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles nil)

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
	evil-want-C-u-scroll t
	evil-undo-system 'undo-fu)

  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init)
  (evil-collection-swap-key nil 'evil-motion-state-map ";" ":")
  )

(use-package magit ;; add forge, github-review, magit gitflow, magit todos
  :ensure t
  :config
  (add-hook 'git-commit-mode-hook 'evil-insert-state))

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  :bind (:map projectile-mode-map
    ("s-p" . projectile-command-map)))

(use-package vterm
  :ensure t)

(use-package vertico
  :ensure t
  :config
  (vertico-mode))


(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless basic) ;; check consult wiki to tweak
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :init
  (marginalia-mode))

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
  :ensure t
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t) ;; remove for emacs 29

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")


(use-package ess
  :ensure t
  :init (require 'ess-site))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package avy
  :ensure t)

;; add anzu
;; add telephone Line
;; add indent guide
;; add flycheck
;; add evil nerd commenter
;; add format all
;; add lsp bridge
;; add company and corfu
;; add yasnippets

;; add dirvish

;; add org-roam, org-bullets

;; add acutex
