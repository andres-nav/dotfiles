;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Andrés Navarro"
      user-mail-address "contact@andresnav.com")

(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil
      password-cache-expiry nil ;; never expire passwords
      )

(setq initial-major-mode 'org-mode
      initial-scratch-message nil)

(setq delete-by-moving-to-trash t)

;;; latex
(setq TeX-view-program-selection '((output-pdf "zathura"))
      TeX-view-program-list '(("zathura" "zathura --page=$(outpage) %o"))
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

        find-file-visit-truename nil ;; don't resolve symlinks when opening files
        )
  )

(defun open-file-in-main-frame ()
  "Open file in main frame."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (when (and file (file-regular-p file))
      (select-frame-by-name "main")
      (dired--find-possibly-alternative-file file)
      )))

(map!
 :after dired
 :map dired-mode-map
 :nv "<return>" #'open-file-in-main-frame
 :nv "l" #'open-file-in-main-frame
 )

(defun find-file-at-path (path)
  "Find a file at a specific path."
  (interactive)
  (let* ((default-directory path)
         (file (read-file-name "Find file: " default-directory)))
    (find-file file)))

(defun run-command-in-scratch (func &optional arg)
  "Run a command in the scratch buffer."
  (interactive)
  (select-frame-by-name "scratchpad")
  (shell-command "emacsclient_custom scratchpad >/dev/null 2>&1")
  (if arg
      (funcall func arg)
    (funcall func))
  )

;; One of my first elisp functions, there is probably a better way to do this. If you know it, please let me know :)
(map!
 :after dired
 :leader
 (:prefix-map ("d" . "directory")
  :desc "pwd" "d"   #'(lambda () (interactive) (run-command-in-scratch 'dired default-directory))
  :desc "projectile" "SPC"   #'(lambda () (interactive) (run-command-in-scratch 'projectile-dired))
  :desc "MEGA     " "m"   #'(lambda () (interactive) (run-command-in-scratch 'dired "~/MEGA/"))
  :desc "git      " "g"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~/git/"))
  :desc "home     " "h"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~"))
  :desc "temp     " "t"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "/tmp/"))
  :desc "Inbox    " "i"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~/MEGA/0_Inbox/"))
  :desc "Projects " "p"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~/MEGA/1_Projects/"))
  :desc "Areas    " "a"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~/MEGA/2_Areas/"))
  :desc "Resources" "r"   #'(lambda () (interactive) (run-command-in-scratch 'find-file-at-path "~/MEGA/3_Resources/"))
  ))


;; openwith
(use-package! openwith
  :after (dired)
  :hook (dired-mode . openwith-mode)
  :custom
  (openwith-associations '(("\\.pdf\\'" "zathura" (file))
                           ("\\.doc\\|\\.docx\\|\\.ppt\\|\\.pptx\\|\\.xls\\|\\.xlsx\\'" "libreoffice" (file))
                           ("\\.png\\|\\.jpg\\|\\.jpeg\\|\\.webp\\|\\.gif\\|\\.bmp\\|\\.tiff\\'" "feh" (file))
                           ))
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

(load! "lisp/+ui")
(load! "lisp/+edit")
(load! "lisp/+org")
