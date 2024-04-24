;;; $DOOMDIR/lisp/+org.el -*- lexical-binding: t; -*-

(setq org-ellipsis " ▼ "
      org-hide-emphasis-markers t
      org-image-actual-width '(0.9)
      org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))
      org-preview-latex-default-process 'dvisvgm
      org-startup-with-latex-preview t
      org-export-in-background t
      org-export-creator-string nil
      )

(setq +directory (expand-file-name "~/MEGA/")
      +directory-inbox (file-name-concat +directory "0_inbox")
      +directory-brain (file-name-concat +directory "1_brain")
      +directory-attachments (file-name-concat +directory "2_attachments")
      +directory-archive (file-name-concat +directory "z_archive")
      +org-default-file "readme.org"

      org-directory +directory
      org-attach-id-dir +directory-attachments
      org-agenda-files (list +directory-brain)
      +org-capture-todo-file (file-name-concat +directory-inbox "todo.org")
      +org-capture-notes-file (file-name-concat +directory-inbox "notes.org")
      org-publish-project-alist '(("org"
                                   :base-directory +directory
                                   :publishing-directory "/tmp/org-publish/"
                                   )) ;; TODO check if it really works
      ;; +org-capture-journal-file (file-name-concat +directory-areas "journal" +org-default-file)
      ;; org-archive-location (file-name-concat +directory-archive "%s::") ;; TODO edit properly
      ;;
      org-roam-directory +directory-brain
      org-roam-db-location (file-name-concat +directory-archive ".org-roam.db")
      org-roam-file-exclude-regexp '(".git/" "node_modules/")
      org-roam-db-update-on-save nil
      org-roam-completion-everywhere nil ;; disable org-roam completition everywhere
      )

;; TODO limit the org agenda files to org files that are not in the archive repo


(after! org
  (setq org-startup-folded 'fold
        org-capture-templates
        '(
          ("t" "Task Inbox" entry
           (file +org-capture-todo-file)
           "* TODO %?\n %i\n %a" :prepend t :empty-lines-after 1)
          ("n" "Note Inbox" entry
           (file +org-capture-notes-file)
           "* %?\n %i\n %a\n %u" :prepend t :empty-lines-after 1)
          ;; ("j" "Journal" entry
          ;;  (file+olp+datetree +org-capture-journal-file)
          ;;  "* %U %?\n%i\n%a" :prepend t)
          ("p" "Projects")
          ("pt" "Task" entry
           (function (org-roam-node-find))
           "* TODO %?\n %i\n %a" :prepend t :empty-lines-after 1)
          ;; ("pt" "Project-local todo" entry
          ;;  (file+headline +org-capture-project-todo-file "Inbox")
          ;;  "* TODO %?\n%i\n%a" :prepend t)
          ;; ("pn" "Project-local notes" entry
          ;;  (file+headline +org-capture-project-notes-file "Inbox")
          ;;  "* %U %?\n%i\n%a" :prepend t)
          ;; ("pc" "Project-local changelog" entry
          ;;  (file+headline +org-capture-project-changelog-file "Unreleased")
          ;;  "* %U %?\n%i\n%a" :prepend t)
          ;; ("o" "Centralized templates for projects")
          ;; ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ;; ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
          ;; ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
          )
        )
  )

(after! org-agenda
  ;; TODO add org super agenda module
  )

;; TODO fix org-archive to archive to the correct location
;; (defun my/org-roam-filter-by-tag (tag-name)
;;   (lambda (node)
;;     (member tag-name (org-roam-node-tags node))))

;; (defun my/org-roam-capture-task ()
;;   (interactive)
;;   ;; Add the project file to the agenda after capture is finished
;;   ;; (add-hook 'org-capture-after-finalize-hook #'my/org-roam-project-finalize-hook)

;;   ;; Capture the new task, creating the project file if necessary
;;   (org-roam-capture- :node (org-roam-node-read
;;                             nil
;;                             (my/org-roam-filter-by-tag "project"))
;;                      :templates '(("p" "project" plain "** TODO %?\n%^{Effort}p\n%^{SCHEDULED}p"
;;                                    :if-new (file+head+olp "%<%Y%m%d%H%M%S>-${slug}.org"
;;                                                           "#+title: ${title}\n#+category: ${title}\n#+filetags: project"
;;                                                           ("Tasks"))))))

(defun my/org-roam-filter-by-tags (tag-names)
  "Filter function to check if the given NODE has the specified TAGS."
  (lambda (node)
    (cl-loop for tag in tag-names
             thereis (member tag (org-roam-node-tags node)))))

(defun my/org-roam-find-project-or-area ()
  "Find and open an Org-roam node based on the \=project\= or \=area\= tags."
  (interactive)
  (org-roam-node-find nil nil
                      (my/org-roam-filter-by-tags '("project" "area"))))

(after! org-roam
  )

(map! :after evil
      :leader
      (:prefix-map ("n" . "notes")
       :desc "Org capture" "n" #'org-capture
       :desc "Find project or area" "f" #'my/org-roam-find-project-or-area
       :desc "Find node" "F" #'org-roam-node-find
       )
      )

                                        ; use leader z for org agenda

;; ;; Offer completion for #tags and @areas separately from notes.
;; (add-to-list 'org-roam-completion-functions #'org-roam-complete-tag-at-point)

;; ;; Make the backlinks buffer easier to peruse by folding leaves by default.
;; (add-hook 'org-roam-buffer-postrender-functions #'magit-section-show-level-2)

;; ;; Open in focused buffer, despite popups
;; (advice-add #'org-roam-node-visit :around #'+popup-save-a)

;; ;; Add ID, Type, Tags, and Aliases to top of backlinks buffer.
;; (advice-add #'org-roam-buffer-set-header-line-format :after #'org-roam-add-preamble-a)
