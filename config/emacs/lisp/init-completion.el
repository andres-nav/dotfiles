;;; init-completion.el --- Initialize completion configuration

;;; Commentary:

;;; Code:

;; A few more useful configurations...
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)

  ;; Only list the commands of the current modes
  (when (boundp 'read-extended-command-predicate)
    (setq read-extended-command-predicate
          #'command-completion-default-include-p))

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :hook (after-init . vertico-mode))

(use-package marginalia
  :hook (after-init . marginalia-mode))

;; TODO: configure consult <https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-completion.el#L73>

;; TODO: configure embark <https://github.com/seagle0128/.emacs.d/blob/master/lisp/init-completion.el#L185>

(provide 'init-completion)

;;; init-completion.el ends here
