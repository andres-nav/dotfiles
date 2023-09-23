;; init-org.el --- Initialize org configurations

;;; Commentary:

;;; Code:

(use-package org
  :diminish org-indent-mode
  :custom
  ;; pretify
  (org-startup-folded t)
  (org-confirm-babel-evaluate nil)
  (org-startup-indented t)
  (org-fontify-whole-heading-line t)
  (org-fontify-quote-and-verse-blocks t)
  (org-list-demote-modify-bullet '(("+" . "-") ("1." . "a.") ("-" . "+")))
  ;; image
  (org-image-actual-width nil)
  ;; more user-friendly
  (org-imenu-depth 4)
  (org-clone-delete-id t)
  (org-use-sub-superscripts '{})
  (org-yank-adjusted-subtrees t)
  (org-ctrl-k-protect-subtree 'error)
  )

(use-package visual-line
  :ensure nil
  :diminish visual-line-mode
  :hook (org-mode . visual-line-mode))

;; Table of contents
(use-package toc-org
  :after org
  :hook (org-mode . toc-org-mode))

(use-package org-bullets
  :after org
  :hook
  (org-mode . org-bullets-mode))


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

(use-package gnuplot
  :after org)

;; Roam
;; (use-package org-roam
;;   :diminish
;;   :defines org-roam-graph-viewer
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n g" . org-roam-graph)
;;          ("C-c n i" . org-roam-node-insert)
;;          ("C-c n c" . org-roam-capture)
;;          ("C-c n j" . org-roam-dailies-capture-today))
;;   :init
;;   (setq org-roam-directory (file-truename centaur-org-directory)
;;         org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag))
;;         org-roam-graph-viewer (if (featurep 'xwidget-internal)
;;                                   #'xwidget-webkit-browse-url
;;                                 #'browse-url))
;;   :config
;;   (unless (file-exists-p org-roam-directory)
;;     (make-directory org-roam-directory))
;;   (add-to-list 'org-agenda-files (format "%s/%s" org-roam-directory "roam"))

;;   (org-roam-db-autosync-enable))

;; (use-package org-roam-ui
;;   :bind ("C-c n u" . org-roam-ui-mode)
;;   :init (when (featurep 'xwidget-internal)
;;           (setq org-roam-ui-browser-function #'xwidget-webkit-browse-url)))

(provide 'init-org)


;;; init-org.el ends here
