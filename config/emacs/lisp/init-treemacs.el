;; init-treemacs.el --- Initialize treemacs configurations

;;; Commentary:

;;; Code:

(use-package treemacs
  :diminish
  )

(use-package treemacs-evil
  :after (treemacs evil)
  )

(use-package treemacs-projectile
  :after (treemacs projectile)
  )

(provide 'init-treemacs)

;;; init-treemacs.el ends here
