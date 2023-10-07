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

  (defun save-and-format ()
    "Keep cursor in the same line with format-all."
    (interactive)
    (let ((line (line-number-at-pos)))
      (goto-char 0)
      (format-all-buffer)
      (forward-line (- line 1))
      )
    )
  )

(provide 'init-format-all)

;;; init-format-all.el ends here
