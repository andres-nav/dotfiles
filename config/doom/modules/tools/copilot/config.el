;;; tools/copilot/config.el -*- lexical-binding: t; -*-

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word))
  :config
  (setq copilot-indent-offset-warning-disable t)

  )

(map! :after (evil copilot)
      :leader :prefix ("t" . "toggle")
      :desc "Fill Column Indicator" "i" #'global-display-fill-column-indicator-mode
      :desc "Copilot" "c" #'copilot-mode)
