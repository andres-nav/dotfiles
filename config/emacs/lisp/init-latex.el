;; init-latex.el --- Initialize format-all configurations

;;; Commentary:

;;; Code:

;; TODO: configure tex
(use-package tex
  :ensure auctex
  :custom
  (TeX-auto-save t)
  (TeX-parse-self t)
  (TeX-master nil)
  (Tex-engine "luatex")
  ;; :hook
  ;; (LaTeX-mode . (lambda ()
  ;;                 (turn-on-reftex)
  ;;                 (setq reftex-plug-into-AUCTeX t)
  ;;                 (reftex-isearch-minor-mode)
  ;;                 (setq TeX-PDF-mode t)
  ;;                 (setq TeX-source-correlate-method 'synctex)
  ;;                 (setq TeX-source-correlate-start-server t)))
  )

(provide 'init-latex)

;;; init-latex.el ends here
