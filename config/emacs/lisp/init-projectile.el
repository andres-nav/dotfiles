;;; init-projectile.el --- Projectile
;;; Commentary:

;;; Code:

(use-package projectile
  :diminish
  :hook (after-init . projectile-mode)
  :bind (:map projectile-mode-map
	            ("s-p" . projectile-command-map)))

;; TODO: configure consult with projectile
;; (use-package consult-projectile
;;   :straight t
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

;; TODO; configure treemacs-proejctile
;; (use-package treemacs-projectile
;;   :straight t
;;   :after projectile treemacs
;;   :demand t)


(provide 'init-projectile)

;;; me-projectile.el ends here
