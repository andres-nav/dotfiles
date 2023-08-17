;; init-base.el --- Better default configurations

;;; Commentary:

;;; Code:

;; Personal information
(setq user-full-name "Andres Navarro"
      user-mail-address "contact@andresnav.com"
      )

(with-no-warnings
  ;; Optimization
  (setq command-line-x-option-alist nil
        ;; Increase how much is read from processes in a single chunk (default is 4kb)
        read-process-output-max #x10000  ; 64kb
        ;; Don't ping things that look like domain names.
        ffap-machine-p-known 'reject
        )
  )

;; Garbage Collector Magic Hack
(use-package gcmh
  :diminish
  :hook (emacs-startup . gcmh-mode)
  :init
  (setq gcmh-idle-delay 'auto
        gcmh-auto-idle-delay-factor 10
        gcmh-high-cons-threshold #x1000000
        )
  ) ; 16MB

;; Set UTF-8 as the default coding system
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(setq system-time-locale "C")
(set-selection-coding-system 'utf-8)

(use-package saveplace
  :hook (after-init . save-place-mode))

(use-package recentf
  :bind (("C-x C-r" . recentf-open-files))
  :hook (after-init . recentf-mode)
  :init (setq recentf-max-saved-items 300
              recentf-exclude
              '("\\.?cache" ".cask" "url" "COMMIT_EDITMSG\\'" "bookmarks"
                "\\.\\(?:gz\\|gif\\|svg\\|png\\|jpe?g\\|bmp\\|xpm\\)$"
                "\\.?ido\\.last$" "\\.revive$" "/G?TAGS$" "/.elfeed/"
                "^/tmp/" "^/var/folders/.+$" "^/ssh:" "/persp-confs/"
                (lambda (file) (file-in-directory-p file package-user-dir))))
  :config
  (push (expand-file-name recentf-save-file) recentf-exclude)
  (add-to-list 'recentf-filename-handlers #'abbreviate-file-name))

(use-package savehist
  :hook (after-init . savehist-mode)
  :init (setq enable-recursive-minibuffers t ; Allow commands in minibuffers
              history-length 1000
              savehist-additional-variables '(mark-ring
                                              global-mark-ring
                                              search-ring
                                              regexp-search-ring
                                              extended-command-history)
              savehist-autosave-interval 300))

(use-package hl-line
  :hook (after-init . global-hl-line-mode))

;; Enable autosave
(use-package files
  :ensure nil
  :preface
  (defun save-all ()
    (interactive)
    (save-some-buffers t))
  :hook
  (after-init . auto-save-visited-mode)
  :config
  (setq auto-save-no-message t
        auto-save-default t
        auto-save-visited-file-name t
        save-abbrevs 'silently
        )

  (setq after-focus-change-function 'save-all)
  )

;; TODO: see <https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-base.el#L142C3-L142C3>

;; Misc
;; Change to y-or-n
(fset 'yes-or-no-p 'y-or-n-p)
(setq use-short-answers t)

(setq visible-bell t
      enable-recursive-minibuffers t   ; Enable recursive minibuffers
      inhibit-compacting-font-caches t ; Don’t compact font caches during GC
      delete-by-moving-to-trash t      ; Deleting files go to OS's trash folder
      make-backup-files nil            ; Forbide to make backup files

      initial-major-mode 'org-mode     ; Set scratch buffer mode to org

      create-lockfiles nil             ; Lockfiles create more pain than benefit

      tab-width 2
      custom-tab-width 2
      indent-tabs-mode nil             ; Only use spaces

      uniquify-buffer-name-style 'post-forward-angle-brackets ; Show path if names are same
      adaptive-fill-regexp "[ t]+|[ t]*([0-9]+.|*+)[ t]*"
      adaptive-fill-first-line-regexp "^* *$"
      sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*"
      sentence-end-double-space nil
      word-wrap-by-category t
      )


;;; Put Emacs auto-save and backup files to /tmp/ or C:/Temp/
(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-by-copying t        ; Avoid symlinks
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      auto-save-list-file-prefix emacs-tmp-dir
      auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t))  ; Change autosave dir to tmp
      backup-directory-alist `((".*" . ,emacs-tmp-dir)))

;; (setq-default major-mode 'text-mode
;;               fill-column 80
;;               tab-width 4
;;               indent-tabs-mode nil)     ; Permanently indent with spaces, never with TABs



;; TODO: set up trash-directory

(provide 'init-base)

;;; init-base.el ends here
