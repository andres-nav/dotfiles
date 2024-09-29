;;; $DOOMDIR/lisp/+org.el -*- lexical-binding: t; -*-

(setq +directory (expand-file-name "~/MEGA/")
      +directory-inbox (file-name-concat +directory "0_inbox")
      +directory-brain (file-name-concat +directory "1_brain")
      +directory-attachments (file-name-concat +directory "2_attachments")
      +directory-archive (file-name-concat +directory "z_archive")
      +file-bibliography (file-name-concat +directory-brain "bibliography.bib")

      org-directory +directory
      org-attach-id-dir +directory-attachments
      +org-capture-todo-file (file-name-concat +directory-inbox "todo.org")
      +org-capture-notes-file (file-name-concat +directory-inbox "notes.org")
      org-publish-project-alist '(("org"
                                   :base-directory +directory
                                   :publishing-directory "/tmp/org-publish/"
                                   )) ;; TODO check if it really works
      org-roam-directory +directory-brain
      org-roam-db-location (file-name-concat +directory-archive ".org-roam.db")
      org-roam-file-exclude-regexp '(".git/" "node_modules/")
      org-roam-db-update-on-save nil
      org-roam-completion-everywhere nil ;; disable org-roam completition everywhere
      org-roam-verbose nil

      citar-bibliography +file-bibliography
      citar-notes-paths (list +directory-brain)
      citar-org-roam-note-title-template "${title}\n#+filetags: :literature:"
      org-cite-global-bibliography (list +file-bibliography)
      citar-file-additional-files-separator "-"
      citar-indicators (list (citar-indicator-create :symbol "" :function #'citar-has-files :tag "has:files")
                             (citar-indicator-create :symbol "" :function #'citar-has-links :tag "has:links")
                             (citar-indicator-create :symbol "" :function #'citar-has-notes :tag "has:notes"))
      )

(after! org
  (setq org-ellipsis " ▼ "
        org-hide-emphasis-markers t
        org-image-actual-width '(0.9)
        org-list-demote-modify-bullet '(("+" . "-") ("-" . "+") ("*" . "+") ("1." . "a."))
        org-preview-latex-default-process 'dvisvgm
        org-startup-with-latex-preview nil
        org-startup-folded 'fold
        org-export-in-background t
        org-export-creator-string nil
        org-cycle-separator-lines 0
        org-tags-column 8
        org-enforce-todo-dependencies t
        org-enforce-todo-checkbox-dependencies t
        org-fast-tag-selection-include-todo t
        org-todo-keywords
        '((sequence "TODO(t)" "PROGRESS(p)" "FOCUS(f)" "|" "DONE(d)" "HOLD(h@/!)" "CANCELED(c@/!)" "HANDLED(l@/!)")
          )
        )
  )

(defun andresnav/org-roam-agenda-files ()
  "Return a list of note files containing project tag." ;
  (seq-uniq
   (seq-map
    #'car
    (org-roam-db-query
     [:select [nodes:file]
      :from tags
      :left-join nodes
      :on (= tags:node-id nodes:id)
      :where (or (like tag (quote "%\"area\"%"))
                 (like tag (quote "%\"project\"%")))]))))

(defun andresnav/agenda-files-update (&rest _)
  "Update the value of `org-agenda-files'."
  (interactive)
  (setq org-agenda-files (andresnav/org-roam-agenda-files)))

(setq org-capture-templates
      '(
        ("t" "Task Inbox" entry
         (file +org-capture-todo-file)
         "* TODO %?\n %i\n %a" :prepend t :empty-lines-after 1)
        ("n" "Note Inbox" entry
         (file +org-capture-notes-file)
         "* %?\n %i\n %a\n %u" :prepend t :empty-lines-after 1)
        ("p" "Projects")
        ("pt" "Task" entry
         (function (org-roam-node-find))
         "* TODO %?\n %i\n %a" :prepend t :empty-lines-after 1)
        )
      )

;; ox-hugo config
(setq org-hugo-base-dir "~/git/github/quartz-andresnav.com"
      org-export-with-broken-links t
      )

(defun andresnav/clear-directories (directory)
  "Remove all subdirectories inside the specified DIRECTORY, leaving files intact."
  (when (file-directory-p directory)
    (dolist (file (directory-files directory t))
      (when (and (file-directory-p file)
                 (not (member (file-name-nondirectory file) '("." ".."))))
        (delete-directory file t t)))))

(defun andresnav/remove-publish-tag (file-path)
  "Remove the publish tag from the front matter of the markdown FILE-PATH."
  (with-temp-buffer
    (insert-file-contents file-path)
    (goto-char (point-min))
    ;; Match the tags line, ensuring it starts with 'tags:' and contains a list
    (when (re-search-forward "^tags = *\\(\\[.*\\]\\)" nil t)
      (let ((tags (match-string 1)))
        ;; Remove the "publish" tag from the list
        (setq tags (replace-regexp-in-string "\"publish\",? *" "" tags))
        ;; If 'publish' was removed and the list is now empty, clean up any trailing commas or whitespace
        (setq tags (replace-regexp-in-string "^,\\|,$" "" tags))
        ;; Replace the original line with the updated tags
        (goto-char (match-beginning 1))
        (delete-region (match-beginning 1) (match-end 1))
        (insert tags)))
    (write-region (point-min) (point-max) file-path)))


(defun andresnav/copy-directory (src dst)
  "Copy SRC directory to DST directory, including all files and subdirectories."
  (unless (file-directory-p src)
    (error "Source directory does not exist: %s" src))
  (when (file-directory-p dst)
    (error "Destination directory already exists: %s" dst))
  (copy-directory src dst t))

(defun andresnav/org-roam-export-publish ()
  "Re-exports all Org-roam files with the publish filetag to Hugo markdown."
  (interactive)
  (when (bound-and-true-p org-hugo-base-dir)
    (let* ((content-dir (expand-file-name "content" org-hugo-base-dir))
           (static-dir (expand-file-name "static" org-hugo-base-dir))
           (ox-hugo-src-dir (expand-file-name "static/ox-hugo" org-hugo-base-dir))
           (ox-hugo-content-dir (expand-file-name "content/ox-hugo" org-hugo-base-dir))
           )

      ;; Clear the content directory
      (when (file-directory-p content-dir)
        (andresnav/clear-directories content-dir))

      ;; Clear the static directory
      (when (file-directory-p static-dir)
        (andresnav/clear-directories static-dir))

      ;; Proceed with the export process
      (dolist (f (org-roam-db-query
                  [:select [nodes:file]
                   :from tags
                   :left-join nodes
                   :on (= tags:node-id nodes:id)
                   :where (like tag (quote "%\"publish\"%"))]))
        (with-current-buffer (find-file (car f))
          (org-hugo-export-to-md)))

      ;; Copy the ox-hugo folder to the content directory
      (when (file-directory-p ox-hugo-src-dir)
        (andresnav/copy-directory ox-hugo-src-dir ox-hugo-content-dir))

      ;; Remove 'publish' tag from all markdown files in content-dir
      (dolist (file (directory-files-recursively content-dir "\\.md$"))
        (andresnav/remove-publish-tag file)))))

;; TODO limit the org agenda files to org files that are not in the archive repo



;; add org-extras to ignore headlines
(after! ox
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines latex-header-blocks)))

(defun andresnav/org-roam-filter-by-tags (tag-names)
  "Filter function to check if the given NODE has the specified TAGS and is not a heading."
  (lambda (node)
    (and (cl-loop for tag in tag-names
                  thereis (member tag (org-roam-node-tags node)))
         (= (org-roam-node-level node) 0))))  ;; Exclude headings (level > 0)

(defun andresnav/org-roam-find-project-or-area ()
  "Find and open an Org-roam node based on the \=project\= or \=area\= tags."
  (interactive)
  (org-roam-node-find nil nil
                      (andresnav/org-roam-filter-by-tags '("project" "area"))))

(defun andresnav/org-roam-find-contact ()
  "Find and open an Org-roam node based on the \=contact\= tag."
  (interactive)
  (org-roam-node-find nil nil
                      (andresnav/org-roam-filter-by-tags '("contact"))))

(defun andresnav/org-roam-find-all ()
  "Find and open an Org-roam node in my brain, including only top-level nodes (non-headings)."
  (interactive)
  (org-roam-node-find nil nil
                      (lambda (node)
                        (= (org-roam-node-level node) 0))))  ;; Filter for top-level nodes only

(map! :after evil
      :map doom-leader-notes-map
      :desc "Org capture" "n" #'org-capture
      (:prefix-map ("f" . "find")
       :desc "Find project or area" "f" #'andresnav/org-roam-find-project-or-area
       :desc "Find node" "SPC" #'andresnav/org-roam-find-all
       :desc "Find contact" "c" #'andresnav/org-roam-find-contact
       :desc "Find all" "a" #'org-roam-node-find
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

(use-package! org-super-agenda
  :hook (org-agenda-mode . org-super-agenda-mode)
  :config
  (setq org-super-agenda-groups '(
                                  (:name "Today"
                                   :time-grid t
                                   :scheduled today)
                                  (:name "Due today"
                                   :deadline today)
                                  (:name "Important"
                                   :priority "A")
                                  (:name "Overdue"
                                   :deadline past)
                                  (:name "Due soon"
                                   :deadline future)
                                  (:name "Projects"
                                   :tag "project")
                                  (:name "Areas"
                                   :tag "area")
                                  ))

  (setq org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator nil
        org-agenda-compact-blocks t
        org-agenda-files (andresnav/org-roam-agenda-files)
        org-agenda-start-day nil ;; i.e. today
        org-agenda-span 1
        org-agenda-start-on-weekday nil)
  (setq org-columns-default-format
        "%TODO %3PRIORITY %40ITEM(Task) %17Effort(Estimated Effort){:} %CLOCKSUM %8TAGS(TAG)")
  (setq org-agenda-custom-commands
        '(("d" "Done tasks" tags "/DONE|CANCELED")
          ("g" "Plan Today"
           ((agenda "" ((org-agenda-span 'day)))
            (org-agenda-skip-function '(org-agenda-skip-deadline-if-not-today))
            (org-agenda-entry-types '(:deadline))
            (org-agenda-overriding-header "Today's Deadlines ")))
          ("c" "Super view"
           ((agenda "" ((org-agenda-overriding-header "")
                        (org-super-agenda-groups
                         '((:name "Today"
                            :time-grid t
                            :date today
                            :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:name "In progress"
                             :todo "IN-PROGRESS"
                             :order 1)
                            (:name "Important"
                             :priority "A"
                             :order 6)
                            (:name "Due Today"
                             :deadline today
                             :order 2)
                            (:name "Scheduled Soon"
                             :scheduled future
                             :order 8)
                            (:name "Overdue"
                             :deadline past
                             :order 7)
                            (:discard (:not (:todo "TODO")))))))))))
  )

(use-package! consult-org-roam
  :after org-roam
  :init
  (require 'consult-org-roam)
  ;; Activate the minor mode
  (consult-org-roam-mode 1)
  :custom
  ;; Use `ripgrep' for searching with `consult-org-roam-search'
  (consult-org-roam-grep-func #'consult-ripgrep)
  ;; Configure a custom narrow key for `consult-buffer'
  (consult-org-roam-buffer-narrow-key ?r)
  ;; Display org-roam buffers right after non-org-roam buffers
  ;; in consult-buffer (and not down at the bottom)
  (consult-org-roam-buffer-after-buffers t)
  :config
  ;; Eventually suppress previewing for certain functions
  (consult-customize
   consult-org-roam-forward-links
   :preview-key "M-.")
  )
