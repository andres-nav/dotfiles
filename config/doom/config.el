;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Andrés Navarro"
      user-mail-address "contact@andresnav.com")

(setq initial-major-mode 'org-mode
      initial-scratch-message nil)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16))

(setq display-line-numbers-type nil) ;; disable line numbers

;; Theme
(setq doom-theme 'doom-gruvbox-light
      doom-gruvbox-light-brighter-modeline t)

;; Completition
(after! company
  (setq company-idle-delay nil))

;; Modeline
(setq +modeline-height 20)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t
      evil-move-beyond-eol nil
      evil-ex-substitute-global t ;; Implicit /g flag on evil ex substitution.
      evil-collection-setup-minibuffer t
      )

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd ":") 'evil-repeat-find-char)
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  )

(after! evil
  (global-set-key [remap evil-quit] 'kill-current-buffer)
  )

;;; flycheck
(after! flycheck
  (setq flycheck-check-syntax-automatically '(save idle-change)
        flycheck-idle-change-delay 0.8))

;;; latex
(setq TeX-view-program-selection '((output-pdf "Zathura"))
      TeX-view-program-list '(("Zathura" "zathura %o"))
      +latex-viewers '(zathura)
      TeX-auto-save t
      TeX-parse-self t
      compilation-ask-about-save nil ;; save all buffers on compilation
      TeX-engine 'luatex
      TeX-command-extra-options "-output-directory=./latexbuild")

;;; dired
(after! dired
  (setq dired-free-space nil
        dired-dwim-target t
        dired-kill-when-opening-new-dired-buffer t ;; only one dired buffer
        dired-recursive-copies 'always
        dired-recursive-deletes 'always
        dired-listing-switches "-AFlGh1v --group-directories-first" ;;  show directories first
        dired-clean-confirm-killing-deleted-buffers nil ;; don't ask to kill buffers visiting deleted files
        dired-auto-revert-buffer #'dired-directory-changed-p ;; auto revert dired buffer when directory changes
        )
  ;; (map! :map dired-mode-map
  ;;       :n "h" #'dired-up-directory
  ;;       :n "l" #'dired-find-alternate-file ;; open file in same buffer and kill dired buffer
  ;;       :n "=" #'dired-create-empty-file
  ;;       )
  )

;;;; Which key
(setq which-key-idle-delay 1)

;; Tabs and final EOL
(setq-default tab-width 8)
(setq require-final-newline t)

;;;; Local variables
(setq-default enable-local-variables t)

;;; :tools magit
(setq magit-repository-directories '(("~/git" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit, it's jarring
      magit-inhibit-save-previous-winconf t
      git-commit-major-mode 'markdown-mode
      magit-commit-ask-to-stage "stage"
      transient-values '((magit-rebase "--autosquash" "--autostash")
                         (magit-pull "--rebase" "--autostash")
                         (magit-revert "--autostash")))

;;; :lang org
(setq org-directory "~/MEGA/"
      org-roam-directory org-directory
      org-roam-db-location (file-name-concat org-directory ".org-roam.db")
      org-roam-file-exclude-regexp '(".git/" "4_Archive/" "node_modules/")
      org-archive-location (file-name-concat org-directory "4_Archive/%s::")
      org-agenda-files (list org-directory)
      org-roam-db-update-on-save nil)

(after! org
  (setq org-startup-folded 'fold
        org-ellipsis " ▼ "
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-src-preserve-indentation t
        )
  (custom-set-faces! `((org-block-begin-line org-block-end-line) :background ,(doom-color 'blue))
    `((org-bold org-italic) :foreground ,(doom-color 'red)))

  (setq org-highlight-latex-and-related '(native entities script)
        org-image-actual-width (/ (display-pixel-width) 3)
        )

  ;; TODO org-roam capture templates
  (after! org-roam
    ;; Offer completion for #tags and @areas separately from notes.
    (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

    ;; Make the backlinks buffer easier to peruse by folding leaves by default.
    (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

    ;; Open in focused buffer, despite popups
    (advice-add #'org-roam-node-visit :around #'+popup-save-a)

    ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
    (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a)
    )
  )

;;; :app everywhere
(after! emacs-everywhere
  ;; Easier to match with a bspwm rule:
  ;;   bspc rule -a 'Emacs:emacs-everywhere' state=floating sticky=on
  (setq emacs-everywhere-frame-name-format "emacs-anywhere")

  ;; The modeline is not useful to me in the popup window. It looks much nicer
  ;; to hide it.
  (remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

  ;; Semi-center it over the target window, rather than at the cursor position
  ;; (which could be anywhere).
  (defadvice! center-emacs-everywhere-in-origin-window (frame window-info)
    :override #'emacs-everywhere-set-frame-position
    (cl-destructuring-bind (x y width height)
        (emacs-everywhere-window-geometry window-info)
      (set-frame-position frame
                          (+ x (/ width 2) (- (/ width 2)))
                          (+ y (/ height 2))))))


;;;; Copilot.el
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (add-to-list 'warning-suppress-types '(copilot)) ;; suppress warnings about copilot
  )

(map! :leader :desc "Copilot"        "t c" #'copilot-mode)

;;; super-save
(use-package! super-save
  :hook (after-init . super-save-mode)
  :custom
  (super-save-auto-save-when-idle t)
  (super-save-idle-duration 30)
  (super-save-silent t)
  (super-save-all-buffers t)
  (auto-save-default nil) ;; Disable auto-save as we use super-save
  (super-save-remote-files nil)
  (super-save-exclude '(".gpg" "COMMIT_EDITMSG" "git-rebase-todo"))
  :config
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-triggers 'magit-status)
  (add-to-list 'super-save-hook-triggers 'focus-out-hook)
  )
