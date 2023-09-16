;;; init-projectile.el --- Projectile
;;; Commentary:

;;; Code:

(use-package projectile
  :diminish
  :hook (after-init . projectile-mode)
  :bind (:map projectile-mode-map
	      ("C-c p" . projectile-command-map))
  :custom
  (projectile-use-git-grep t)
  (projectile-globally-ignored-files '("TAGS" "tags" ".DS_Store"))
  (projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o" ".swp" ".so" ".a"))
  )

;; TODO: configure consult with projectile
;; (use-package consult-projectile
;;   :ensure t
;;   :init
;;   (+map!
;;    ":"  '(consult-projectile-find-file :wk "Find file in project")
;;    ;; Buffer
;;    "bp" #'consult-projectile-switch-to-buffer
;;    ;; Project
;;    "pp" #'consult-projectile
;;    "pP" '(consult-projectile-switch-project :wk "Switch")
;;    "pR" #'consult-projectile-recentf
;;    "pd" '(consult-projectile-find-dir :wk "Find directory")
;;    "pf" '(consult-projectile-find-file :wk "Find file")))

(provide 'init-projectile)

;;; init-projectile.el ends here
