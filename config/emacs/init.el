
;;; Code:
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
(global-hl-line-mode 1)

(setq
 inhibit-startup-message t
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


(auto-save-visited-mode t) ;; makes autosaves save to current file

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


;; Tabs
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width)
  (setq evil-shift-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; Configuration for ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)

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

  (defadvice evil-window-split (after move-point-to-new-window activate)
    (other-window 1))

  (defadvice evil-window-vsplit (after move-point-to-new-window activate)
    (other-window 1))

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

(use-package sqlite3
  :ensure t)

(use-package forge
  :ensure t
  :after magit)

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
  :ensure t
  :after tree-sitter) ;; remove for emacs 29

(use-package nix-mode
  :ensure t
  ;; :hook (nix-mode . lsp-deferred)
  :mode "\\.nix\\'")

(use-package ess
  :ensure t
  :init (require 'ess-site))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package avy
  :ensure t
  :config
  (evil-define-key nil evil-normal-state-map
    "s" 'evil-avy-goto-char-2)
  )

(use-package telephone-line
  :ensure t
  :config
  (setq telephone-line-lhs
	      '((evil   . (telephone-line-evil-tag-segment))
          (accent . (telephone-line-vc-segment
                     telephone-line-erc-modified-channels-segment
                     telephone-line-process-segment))
          (nil    . (telephone-line-minor-mode-segment
                     telephone-line-buffer-segment))))
  (setq telephone-line-rhs
	      '((nil    . (telephone-line-misc-info-segment))
          (accent . (telephone-line-major-mode-segment))
          (evil   . (telephone-line-airline-position-segment))))
  (telephone-line-mode t)
  )

(use-package flycheck
  :ensure t
  :hook (prog-mode . flycheck-mode))

(use-package company
  :ensure t
  :config
  (global-company-mode t)
  )

(use-package corfu ;; TODO: check if it really works
  :ensure t
  :config
  (global-corfu-mode t)
  )

(use-package eglot
  :ensure t)

;; (use-package lsp-mode
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (prog-mode . lsp)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands lsp)

;; (use-package lsp-ui :commands lsp-ui-mode)

;; add anzu
;; add indent guide
;; add evil nerd commenter
;; add yasnippets

;; (use-package dirvish
;;   :ensure t)

;; add org-roam, org-bullets org-roam-bibtex

;; fix line wraping

;; add prespective-el

;; add ripgrep (rg.el)

(use-package format-all
  :ensure t
  :preface
  (defun format-code ()
    "Auto-format whole buffer."
    (interactive)
    (if (derived-mode-p 'prolog-mode)
        (prolog-indent-buffer)
      (format-all-buffer)))
  :config
  (add-to-list 'format-all-default-formatters '("Nix" alejandra))
  (global-set-key (kbd "M-F") #'format-code)
  (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
  (add-hook 'prog-mode-hook 'format-all-mode)
  )

(use-package org
  :config
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (setq org-startup-folded t)
  )

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/MEGA/Notes/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package solidity-mode
  :ensure t)

(use-package solidity-flycheck
  :ensure t)

(use-package company-solidity
  :ensure t)

(use-package web-mode
  :ensure t
  :config

  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
	            (when (string-equal "tsx" (file-name-extension buffer-file-name))
		            (setup-tide-mode))))

  ;; enable typescript - tslint checker
  ;; fix rome for flycheck
  )
