;; init-flycheck.el --- Initialize flycheck configurations

;;; Commentary:

;;; Code:

(use-package flycheck
  :diminish
  :hook (prog-mode . flycheck-mode)
  :custom
  (flycheck-temp-prefix ".flycheck")
  (flycheck-check-syntax-automatically '(save mode-enabled))
  (flycheck-emacs-lisp-load-path 'inherit)
  (flycheck-indication-mode 'right-fringe)
  )

;; (use-package sideline
;;   :diminish sideline-mode
;;   :hook (flycheck-mode . sideline-mode)
;;   :init (setq sideline-backends-right '(sideline-flycheck)))

;; (use-package sideline-flycheck :hook (flycheck-mode . sideline-flycheck-setup))

(use-package jinx
  :ensure nil
  :diminish
  :hook (after-init . global-jinx-mode)
  :bind (("C-," . jinx-correct)
         ("C-M-," . jinx-languages)))

(provide 'init-check)

;;; init-flycheck.el ends here
