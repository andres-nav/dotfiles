;; init-treesitter.el --- Initialize treesitter configurations

;;; Commentary:

;;; Code:

(use-package tree-sitter
  :diminish
  :hook (prog-mode . tree-sitter-mode)
  :config
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :diminish
  :after tree-sitter)

;; TODO: make langs to install automatically

(provide 'init-treesitter)

;;; init-treesitter.el ends here
