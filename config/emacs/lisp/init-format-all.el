;; init-format-all.el --- Initialize format-all configurations

;;; Commentary:

;;; Code:

(use-package format-all
  :diminish
  :hook
  (prog-mode . format-all-mode)
  (format-all-mode . format-all-ensure-formatter)
  :config
  (setq format-all-show-errors 'never)
  (add-to-list 'format-all-default-formatters '("Nix" alejandra))
  )

(provide 'init-format-all)

;;; init-format-all.el ends here
