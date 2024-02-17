;; init-format-all.el --- Initialize format-all configurations

;;; Commentary:

;;; Code:

(use-package format-all
  :diminish
  :hook (prog-mode . format-all-ensure-formatter)
  :custom
  (format-all-show-errors 'never)
  :config
  (add-to-list 'format-all-default-formatters '(("Nix" alejandra)))
  )

(provide 'init-format-all)

;;; init-format-all.el ends here
