;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Andrés Navarro"
      user-mail-address "contact@andresnav.com")

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
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; :completion company
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(after! company
  (setq company-idle-delay nil))

;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(after! doom-modile
  (setq doom-modeline-modal nil
        doom-modeline-major-mode-icon t
        doom-modeline-height 25)
  )

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t
      evil-move-beyond-eol t)

(after! evil
  (global-set-key [remap evil-quit] 'kill-current-buffer)
  )

;; Implicit /g flag on evil ex substitution, because I use the default behavior
;; less often.
(setq evil-ex-substitute-global t)

(setq evil-collection-setup-minibuffer t)

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
(setq which-key-idle-delay 0.3)

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
  (setq org-startup-folded 'show2levels
        org-ellipsis " ▼ "
        org-hide-emphasis-markers t
        org-src-fontify-natively t
        )
  ;; (custom-set-faces! `((org-block-begin-line org-block-end-line) :background ,(doom-color 'blue))
  ;;   `((org-bold org-italic) :foreground ,(doom-color 'red)))
  (setq org-highlight-latex-and-related '(native entities script)
        org-image-actual-width (min (/ (frame-pixel-width) 2) 800))
  )

;; TODO Formatter for vhdl example for sql
;; (after! sql
;; set formatter to sql-formatter
;; (set-formatter!
;;   'sql-formatter
;;   "sql-formatter"
;;   :modes '(sql-mode)))


;; TODO org-roam capture templates

(after! org-tree-slide
  ;; I use g{h,j,k} to traverse headings and TAB to toggle their visibility, and
  ;; leave C-left/C-right to .  I'll do a lot of movement because my
  ;; presentations tend not to be very linear.
  (setq org-tree-slide-skip-outline-level 2))

(after! org-roam
  ;; Offer completion for #tags and @areas separately from notes.
  (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

  ;; Make the backlinks buffer easier to peruse by folding leaves by default.
  (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

  ;; Open in focused buffer, despite popups
  (advice-add #'org-roam-node-visit :around #'+popup-save-a)

  ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
  (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a))

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
;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (add-to-list 'warning-suppress-types '(copilot)))

(map! :leader :desc "Copilot"        "t c" #'copilot-mode)

;;; super-save
(use-package! super-save
  :hook (after-init . super-save-mode)
  :custom
  (super-save-auto-save-when-idle t)
  (super-save-silent t)
  (auto-save-default nil) ;; Disable auto-save as we use super-save
  (super-save-delete-trailing-whitespace t)
  (super-save-remote-files nil)
  (super-save-exclude '(".gpg" "COMMIT_EDITMSG" "git-rebase-todo"))
  (super-save-triggers
   '(ace-window
     evil-window-next evil-window-prev
     evil-window-right evil-window-left
     evil-window-up evil-window-down
     other-window
     next-buffer previous-buffer))
  )
