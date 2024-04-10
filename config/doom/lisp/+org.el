;;; $DOOMDIR/lisp/+org.el -*- lexical-binding: t; -*-

(setq org-directory (expand-file-name "~/MEGA/")
      org-agenda-files (list org-directory)
      org-archive-location (file-name-concat org-directory "4_Archive/%s::")
      )

(setq org-startup-folded 'fold
      org-ellipsis " ▼ "
      org-hide-emphasis-markers t
      org-image-actual-width '(0.9)
      org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))
      org-preview-latex-default-process 'dvisvgm
      org-startup-with-latex-preview t
      )

(setq org-roam-directory org-directory
      org-roam-db-location (file-name-concat org-directory ".org-roam.db")
      org-roam-file-exclude-regexp '(".git/" "4_Archive/" "node_modules/")
      org-roam-db-update-on-save nil
      org-roam-completion-everywhere nil ;; disable org-roam completition everywhere
      )

;; (after! org-roam
;; ;; Offer completion for #tags and @areas separately from notes.
;; (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

;; ;; Make the backlinks buffer easier to peruse by folding leaves by default.
;; (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

;; ;; Open in focused buffer, despite popups
;; (advice-add #'org-roam-node-visit :around #'+popup-save-a)

;; ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
;; (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a)

;; )
