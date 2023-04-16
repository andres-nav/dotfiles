;;; tools/jinx/config.el -*- lexical-binding: t; -*-

(use-package! jinx
  :defer t
  :init
  (add-hook 'doom-init-ui-hook #'global-jinx-mode)
  :config
  (push 'org-inline-src-block
        (alist-get 'org-mode jinx-exclude-faces))

  ;; Take over the relevant bindings.
  (after! ispell
    (global-set-key [remap ispell-word] #'jinx-correct))
  (after! evil-commands
    (global-set-key [remap evil-next-flyspell-error] #'jinx-next)
    (global-set-key [remap evil-prev-flyspell-error] #'jinx-previous))

  ;; I prefer for `point' to end up at the start of the word,
  ;; not just after the end.
  (advice-add 'jinx-next :after (lambda (_) (left-word)))
  )
