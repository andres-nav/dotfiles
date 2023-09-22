;; init-treesit.el --- Initialize treesit configurations

;;; Commentary:

;;; Code:

(use-package treesit-auto
  :hook
  (after-init . global-treesit-auto-mode)
  :custom
  (treesit-auto-install 'prompt)
  :config
  (setq my-nix-tsauto-config
	(make-treesit-auto-recipe
	 :lang 'nix
	 :ts-mode 'nix-ts-mode
	 :remap 'nix-mode
	 :url "https://github.com/nix-community/tree-sitter-nix"
	 :revision "master"
	 :source-dir "src"))

  (add-to-list 'treesit-auto-recipe-list my-nix-tsauto-config)
  )

;; ;; TODO: make langs to install automatically

;; ;; TODO: add textobjects
(use-package evil-textobj-tree-sitter
  :diminish
  )

(provide 'init-treesit)

;;; init-treesit.el ends here
