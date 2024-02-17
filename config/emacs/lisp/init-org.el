;; init-org.el --- Initialize org configurations

;;; Commentary:

;;; Code:

(use-package org
  :diminish org-indent-mode
  :custom
  ;; pretify
  (org-startup-indented t) ;; start with everything indented
  (org-startup-folded t) ;; start with everything folded

  (org-fontify-whole-heading-line t)
  (org-fontify-quote-and-verse-blocks t)
  (org-fontify-done-headline t)
  (org-pretty-entities t)

  (org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+")))
  (org-hidden-keywords '(title))
  (org-ellipsis " ▼ ")

  ;; image
  (org-image-actual-width nil)
  (org-display-remote-inline-images 'cache)

  ;; org code
  (org-confirm-babel-evaluate nil) ;; don't ask for confirmation when evaluating code blocks
  (org-src-fontify-natively t)
  (org-src-tab-acts-natively t)
  (org-src-window-setup 'current-window)

  ;; more user-friendly
  (org-imenu-depth 4)
  (org-clone-delete-id t)
  (org-use-sub-superscripts '{})
  (org-yank-adjusted-subtrees t)
  (org-list-allow-alphabetical t)
  (org-ctrl-k-protect-subtree 'error)

  (org-display-custom-times t)
  (org-time-stamp-custom-formats '("<%d %b %Y>" . "<%Y-%m-%d %H:%M>"))

  (org-hide-emphasis-markers t) ; hides the / and * characters around emphasized text

  (org-latex-compiler "xelatex")
  (org-latex-pdf-process '("xelatex %f"))
  (org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))

  (org-todo-keywords
   '((sequence "TODO" "DOING" "REVIEW" "WAITING" "|" "DONE" "CANCELED")))

  :config
  (font-lock-add-keywords 'org-mode
                          '(("\\*\\(.*?\\)\\*" 1 '(face (:foreground "tomato")) prepend)))
  (font-lock-add-keywords 'org-mode
                          '((" _\\(.*?\\)_ " 1 '(face (:foreground "cyan")) prepend)))


  (defun my-org-evil-open-no-indent-advice (orig-func &rest args)
    "Advice function to customize evil-open-below in Org mode."
    (apply orig-func args)
    (if (and evil-auto-indent (eq major-mode 'org-mode))
	(progn
          (when (and (org-in-item-p) (not (org-at-item-p)) (not (org-in-src-block-p)))
            (save-excursion
              (beginning-of-line)
              (delete-horizontal-space))
            ))
      ))


  (advice-add 'evil-open-below :around #'my-org-evil-open-no-indent-advice)
  (advice-add 'evil-open-above :around #'my-org-evil-open-no-indent-advice)

(org-babel-do-load-languages
   'org-babel-load-languages
   '(;; other Babel languages
     (python . t)
     ))
  )

(use-package visual-line
  :ensure nil
  :diminish visual-line-mode
  :hook (org-mode . visual-line-mode))

;; Table of contents
(use-package toc-org
  :after org
  :hook (org-mode . toc-org-mode))

(use-package org-modern
  :ensure nil
  :after org
  :hook
  (org-mode . org-modern-mode)
  :custom
  (org-modern-list
   '((?- . "●")
     (?+ . "○")
     (?* . "■")))

  (org-modern-checkbox
   '((?X . "☑")
     (?- . #("☐–" 0 2 (composition ((2)))))
     (?\s . "☐")))
  ;; This is usually the default, but keep in mind it must be nil
  ;; (org-hide-leading-stars nil)
  ;; This line is necessary.
  ;; (org-superstar-leading-bullet ?\s)
  ;; (org-superstar-leading-fallback ?\s)
  ;; If you use Org Indent you also need to add this, otherwise the
  ;; above has no effect while Indent is enabled.
  ;; (org-indent-mode-turns-on-hiding-stars nil)
  ;; :config
  ;; (set-face-attribute 'org-level-8 nil :weight 'bold :inherit 'default)
  ;; Low levels are unimportant => no scaling
  ;; (set-face-attribute 'org-level-7 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-6 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-5 nil :inherit 'org-level-8)
  ;; (set-face-attribute 'org-level-4 nil :inherit 'org-level-8)
  ;; Top ones get scaled the same as in LaTeX (\large, \Large, \LARGE)
  ;; (set-face-attribute 'org-level-3 nil :inherit 'org-level-8 :height 1.2) ;\large
  ;; (set-face-attribute 'org-level-2 nil :inherit 'org-level-8 :height 1.44) ;\Large
  ;; (set-face-attribute 'org-level-1 nil :inherit 'org-level-8 :height 1.728) ;\LARGE
  ;; :config
  )


;; Write codes in org-mode
;; (use-package org-src
;;   :ensure nil
;;   :hook (org-babel-after-execute . org-redisplay-inline-images)
;;   :bind (:map org-src-mode-map
;;          ;; consistent with separedit/magit
;;          ("C-c C-c" . org-edit-src-exit))
;;   :custom
;;   (org-confirm-babel-evaluate nil)
;;   (org-src-fontify-natively t)
;;   (org-src-tab-acts-natively t)
;;   (org-src-window-setup 'other-window)
;;   (org-src-lang-modes '(("C"      . c)
;;                         ("C++"    . c++)
;;                         ("bash"   . sh)
;;                         ("cpp"    . c++)
;;                         ("dot"    . graphviz-dot) ;; was `fundamental-mode'
;;                         ("elisp"  . emacs-lisp)
;;                         ("ocaml"  . tuareg)
;;                         ("shell"  . sh)))
;;   (org-babel-load-languages '((C          . t)
;;                               (dot        . t)
;;                               (emacs-lisp . t)
;;                               (eshell     . t)
;;                               (python     . t)
;;                               (shell      . t))))

(use-package org-roam
  :after org
  :hook (org-mode . org-roam-db-autosync-mode)
  :custom
  (org-roam-directory (file-truename "~/MEGA"))
  (org-roam-database-connector 'sqlite-builtin)
  (org-roam-file-exclude-regexp '(".git/" "4_Archive/"))
  (org-roam-list-files-commands '(fd fdfind rg find))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (unless (file-exists-p org-roam-directory)
    (make-directory org-roam-directory))
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  )

(use-package gnuplot
  :after org)

;; (use-package org-roam-ui
;;   :bind ("C-c n u" . org-roam-ui-mode)
;;   :init (when (featurep 'xwidget-internal)
;;           (setq org-roam-ui-browser-function #'xwidget-webkit-browse-url)))

(provide 'init-org)


;;; init-org.el ends here
