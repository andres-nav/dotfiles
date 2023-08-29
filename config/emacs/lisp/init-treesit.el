;; init-treesit.el --- Initialize treesit configurations

;;; Commentary:

;;; Code:

(use-package treesit
  :ensure nil
  :diminish)

;; (use-package treesit-auto
;;   :hook
;;   (after-init . global-treesit-auto-mode)
;;   :config
;;   (setq treesit-auto-install 't)

;;   (setq nix-tsauto-config
;; 	(make-treesit-auto-recipe
;; 	 :lang 'nix
;; 	 :ts-mode 'nix-ts-mode
;; 	 :remap '(nix-mode)
;; 	 :url "https://github.com/nix-community/tree-sitter-nix"
;; 	 :revision "master"
;; 	 :source-dir "src"))

;;   (add-to-list 'treesit-auto-recipe-list nix-tsauto-config)
;;   (treesit-auto-install-all)

;;   )
;; :hook
;; (prog-mode . tree-sitter-mode)
;; (tree-sitter-mode . tree-sitter-hl-mode))

;; (use-package tree-sitter-langs
;;   :diminish
;;   :after tree-sitter)

;; ;; TODO: make langs to install automatically

;; ;; TODO: add textobjects
;; (use-package evil-textobj-tree-sitter
;;   :diminish
;;   )

(provide 'init-treesit)

;;; init-treesit.el ends here
