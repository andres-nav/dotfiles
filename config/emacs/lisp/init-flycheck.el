;; init-flymake.el --- Initialize flymake configurations

;;; Commentary:

;;; Code:

(use-package flycheck
  :diminish
  :hook (prog-mode . flycheck-mode))

(use-package sideline
  :diminish sideline-mode
  :hook (flycheck-mode . sideline-mode)
  :init (setq sideline-backends-right '(sideline-flycheck)))

(use-package sideline-flycheck :hook (flycheck-mode . sideline-flycheck-setup))

(provide 'init-flycheck)

;;; init-flymake.el ends here
