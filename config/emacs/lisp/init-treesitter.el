;; init-treesitter.el --- Initialize treesitter configurations

;;; Commentary:

;;; Code:

(use-package treesit
  :ensure nil
  :diminish
  :hook
  (prog-mode . tree-sitter-mode)
  (tree-sitter-mode . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :diminish
  :after tree-sitter)

;; TODO: make langs to install automatically

;; TODO: add textobjects
(use-package evil-textobj-tree-sitter
  :diminish
  )

(provide 'init-treesitter)

;;; init-treesitter.el ends here
