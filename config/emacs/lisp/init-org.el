;; init-org.el --- Initialize org configurations

;;; Commentary:

;;; Code:

(use-package org
  :hook
  (org-mode . visual-line-mode)
  :config
  (setq org-startup-folded t
	org-confirm-babel-evaluate nil)
  )

(use-package org-indent
  :ensure nil
  :diminish
  :after org
  :hook (org-mode . org-indent-mode))

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
