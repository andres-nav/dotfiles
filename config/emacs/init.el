;;; init.el --- core initiazliation file
;;; Commentary:

;;; Code:

;; Don't pass case-insensitive to `auto-mode-alist'
(setq auto-mode-case-fold nil)


(unless (or (daemonp) noninteractive init-file-debug)
  ;; Suppress file handlers operations at startup
  ;; `file-name-handler-alist' is consulted on each call to `require' and `load'
  (let ((old-value file-name-handler-alist))
    (setq file-name-handler-alist nil)
    (set-default-toplevel-value 'file-name-handler-alist file-name-handler-alist)
    (add-hook 'emacs-startup-hook
              (lambda ()
                "Recover file name handlers."
                (setq file-name-handler-alist
                      (delete-dups (append file-name-handler-alist old-value))))
              101)))

;; Load path
;; Optimize: Force "lisp"" and "site-lisp" at the head to reduce the startup time.
(defun update-load-path (&rest _)
  "Update `load-path'."
  (dolist (dir '("site-lisp" "lisp"))
    (push (expand-file-name dir user-emacs-directory) load-path)))

(defun add-subdirs-to-load-path (&rest _)
  "Add subdirectories to `load-path'.

Don't put large files in `site-lisp' directory, e.g. EAF.
Otherwise the startup will be very slow."
  (let ((default-directory (expand-file-name "site-lisp" user-emacs-directory)))
    (normal-top-level-add-subdirs-to-load-path)))

(advice-add #'package-initialize :after #'update-load-path)
(advice-add #'package-initialize :after #'add-subdirs-to-load-path)

(update-load-path)

;; Packages
(require 'init-package)

;; Preferences
(require 'init-base)

(require 'init-ui)
(require 'init-edit)
(require 'init-evil)
(require 'init-completion)
;; TODO: add corfu
;; TODO: add yasnippets
(require 'init-projectile)
(require 'init-vcs)

;; Progamming
(require 'init-flycheck)
(require 'init-treesitter)

;; (global-hl-line-mode 1)


;; (auto-save-visited-mode t) ;; makes autosaves save to current file

;; (defun save-all ()
;;   (interactive)
;;   (save-some-buffers t))

;; (add-hook 'focus-out-hook 'save-all) ;; hook to autosave when loosing focus

;; ;; Separate custom vars into another file
;; (setq custom-file (locate-user-emacs-file "custom-vars.el"))
;; (load custom-file 'noerror 'nomessage)

;; ;;; Put Emacs auto-save and backup files to /tmp/ or C:/Temp/
;; (defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
;; (setq
;;  backup-by-copying t                                        ; Avoid symlinks
;;  delete-old-versions t
;;  kept-new-versions 6
;;  kept-old-versions 2
;;  version-control t
;;  auto-save-list-file-prefix emacs-tmp-dir
;;  auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))  ; Change autosave dir to tmp
;;  backup-directory-alist `((".*" . ,emacs-tmp-dir)))

;; ;;; Lockfiles unfortunately cause more pain than benefit
;; (setq create-lockfiles nil)


;; ;; Tabs
;; (setq custom-tab-width 2)

;; ;; Two callable functions for enabling/disabling tabs in Emacs
;; (defun disable-tabs () (setq indent-tabs-mode nil))
;; (defun enable-tabs  ()
;;   (local-set-key (kbd "TAB") 'tab-to-tab-stop)
;;   (setq indent-tabs-mode t)
;;   (setq tab-width custom-tab-width)
;;   (setq evil-shift-width custom-tab-width))

;; ;; Hooks to Enable Tabs
;; (add-hook 'prog-mode-hook 'enable-tabs)
;; ;; Hooks to Disable Tabs
;; (add-hook 'lisp-mode-hook 'disable-tabs)
;; (add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; ;; Language-Specific Tweaks
;; (setq-default python-indent-offset custom-tab-width) ;; Python
;; (setq-default js-indent-level custom-tab-width)      ;; Javascript

;; ;; Make the backspace properly erase the tab instead of
;; ;; removing 1 space at a time.
;; (setq backward-delete-char-untabify-method 'hungry)

;; ;; (OPTIONAL) Shift width for evil-mode users
;; ;; For the vim-like motions of ">>" and "<<".
;; (setq-default evil-shift-width custom-tab-width)

;; ;; Config for dired
;; (put 'dired-find-alternate-file 'disabled nil)
;; (setq dired-listing-switches "-agho --group-directories-first"
;;       dired-dwin-target t
;;       delete-by-moving-to-trash t)

;; (eval-after-load "dired"
;;   '(progn
;;      (defadvice dired-advertised-find-file (around dired-subst-directory activate)
;;        "Replace current buffer if file is a directory."
;;        (interactive)
;;        (let* ((orig (current-buffer))
;;               ;; (filename (dired-get-filename))
;;               (filename (dired-get-filename t t))
;;               (bye-p (file-directory-p filename)))
;;          ad-do-it
;;          (when (and bye-p (not (string-match "[/\\\\]\\.$" filename)))
;;            (kill-buffer orig))))))

;; (setq dired-guess-shell-alist-user `(("\\.pdf\\'" "zathura")
;;                                      ("\\.jpe?g\\'" "gimp")
;;                                      ("\\.mp4\\'" "vlc")))
;; (use-package dired
;;   :after evil
;;   :config
;;   (evil-define-key 'normal dired-mode-map
;;     "h" 'dired-jump)
;;   (evil-define-key 'normal dired-mode-map
;;     "l" 'dired-find-alternate-file)
;;   (evil-define-key 'normal dired-mode-map
;;     "l" 'dired-find-alternate-file)
;;   )

;; ;; Hide hidden files
;; (use-package dired-hide-dotfiles
;;   :ensure t
;;   :hook
;;   (dired-mode . dired-hide-dotfiles-mode)
;;   :config

;;   (evil-define-key 'normal dired-mode-map
;;     "." 'dired-hide-dotfiles-mode)
;;   )

;; ;; TODO consult, evil-terminal-cursor-changer, clipetty

;; (use-package nix-mode
;;   :ensure t
;;   ;; :hook (nix-mode . lsp-deferred)
;;   :mode "\\.nix\\'")

;; (use-package ess
;;   :ensure t
;;   :init (require 'ess-site))



;; (use-package company
;;   :ensure t
;;   :config
;;   (global-company-mode t)
;;   )

;; (use-package eglot
;;   :ensure t)


;; ;; add anzu
;; ;; add indent guide
;; ;; add evil nerd commenter
;; ;; add yasnippets

;; ;; add org-roam, org-bullets org-roam-bibtex

;; ;; fix line wraping

;; ;; add prespective-el

;; ;; add ripgrep (rg.el)

;; (use-package format-all
;;   :ensure t
;;   :preface
;;   (defun format-code ()
;;     "Auto-format whole buffer."
;;     (interactive)
;;     (if (derived-mode-p 'prolog-mode)
;;         (prolog-indent-buffer)
;;       (format-all-buffer)))
;;   :config
;;   (setq format-all-show-errors 'never)
;;   (add-to-list 'format-all-default-formatters '("Nix" alejandra))
;;   (global-set-key (kbd "M-F") #'format-code)
;;   (add-hook 'prog-mode-hook #'format-all-ensure-formatter)
;;   (add-hook 'prog-mode-hook 'format-all-mode)
;;   )

;; (use-package org
;;   :config
;;   (add-hook 'org-mode-hook 'org-indent-mode)
;;   (add-hook 'org-mode-hook 'visual-line-mode)
;;   (setq org-startup-folded t)
;;   )

;; (use-package org-roam
;;   :ensure t
;;   :custom
;;   (org-roam-directory (file-truename "~/MEGA/Notes/"))
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n g" . org-roam-graph)
;;          ("C-c n i" . org-roam-node-insert)
;;          ("C-c n c" . org-roam-capture)
;;          ;; Dailies
;;          ("C-c n j" . org-roam-dailies-capture-today))
;;   :config
;;   ;; If you're using a vertical completion framework, you might want a more informative completion interface
;;   (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
;;   (org-roam-db-autosync-mode)
;;   ;; If using org-roam-protocol
;;   (require 'org-roam-protocol))

;; (use-package org-bullets
;;   :ensure t
;;   :config
;;   (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (use-package solidity-mode
;;   :ensure t)

;; (use-package solidity-flycheck
;;   :ensure t)

;; (use-package company-solidity
;;   :ensure t)

;; (use-package web-mode
;;   :ensure t
;;   :config

;;   (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
;;   (add-hook 'web-mode-hook
;;             (lambda ()
;;               (when (string-equal "tsx" (file-name-extension uffer-file-name))
;;                 (setup-tide-mode))))

;;   ;; enable typescript - tslint checker
;;   ;; fix rome for flycheck
;;   )
