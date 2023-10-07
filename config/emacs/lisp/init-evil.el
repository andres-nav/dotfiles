;; init-evil.el --- Initialize evil configurations

;;; Commentary:

;;; Code:

;; good docs <https://github.com/condy0919/.emacs.d/blob/336f30dccd03f3e7b6c07d22c71d61aa26d61351/lisp/init-evil.el#L20>

(use-package evil
  :diminish
  :hook (after-init . evil-mode)
  :custom
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol t)
  (evil-shift-width 4)
  (evil-esc-delay 0)
  (evil-echo-state nil)
  (evil-undo-system 'undo-fu)

  ;; Rebind `f'/`s' to mimic `evil-snipe'.
  :bind (
         :map evil-motion-state-map
         ("f" . evil-avy-goto-char-in-line)
         :map evil-motion-state-map
         ("t" . evil-avy-goto-char-in-line)
         :map evil-normal-state-map
         ("r" . evil-avy-goto-char-timer )
         :map evil-motion-state-map
         ("r" . evil-avy-goto-char-timer )
         :map evil-normal-state-map
         ("R" . evil-avy-goto-line)
         :map evil-motion-state-map
         ("R" . evil-avy-goto-line)
	 )

  :config
  (defadvice evil-window-split (after move-point-to-new-window activate)
    (other-window 1))
  (defadvice evil-window-vsplit (after move-point-to-new-window activate)
    (other-window 1))

  (global-set-key [remap evil-quit] 'kill-current-buffer)
  ;; (defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))
  ;; (evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)

  ;; esc quits
  ;; TODO: check if it works
  ;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
  ;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
  ;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  ;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  ;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  ;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  ;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  )

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (evil-collection-swap-key nil 'evil-motion-state-map ";" ":")
  :init (evil-collection-init)
  )

(use-package evil-leader
  :diminish
  :after evil-collection
  :hook (after-init . global-evil-leader-mode)
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "b" 'ido-switch-buffer
    "f" 'projectile-find-file
    "D" 'projectile-find-dir
    "d" 'projectile-dired
    "p" 'projectile-switch-project
    "g" 'projectile-ripgrep
    "G" 'rg-menu
    "v" 'projectile-vc
    "w" 'evil-window-map
    )
  )


(use-package evil-surround
  :diminish
  :after evil-collection
  :hook (evil-mode . global-evil-surround-mode))

;; TODO: install evil-indent-plus

;; TODO: install evil-easymotion

(use-package evil-commentary
  :diminish
  :after evil-collection
  :hook (evil-mode . evil-commentary-mode))

;; Package to align characters
(use-package evil-lion
  :diminish
  :after evil-collection
  :hook (evil-mode . evil-lion-mode))

;; Extend matching corresponding elements
(use-package evil-matchit
  :diminish
  :after evil
  :hook (evil-mode . global-evil-matchit-mode))

(provide 'init-evil)

;;; init-evil.el ends here
