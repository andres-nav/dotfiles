;; init-evil.el --- Initialize evil configurations

;;; Commentary:

;;; Code:

;; good docs <https://github.com/condy0919/.emacs.d/blob/336f30dccd03f3e7b6c07d22c71d61aa26d61351/lisp/init-evil.el#L20>

(use-package evil
  :diminish
  :hook (after-init . evil-mode)
  (after-save . evil-normal-state)
  :custom
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-Y-yank-to-eol t)
  (evil-shift-width 2)
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
         ("s" . evil-avy-goto-char-timer))

  :config
  (defadvice evil-window-split (after move-point-to-new-window activate)
    (other-window 1))
  (defadvice evil-window-vsplit (after move-point-to-new-window activate)
    (other-window 1))


  (global-set-key [remap evil-quit] 'kill-current-buffer)
  ;; (defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))
  ;; (evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)

  )

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :after evil
  :config
  (evil-collection-swap-key nil 'evil-motion-state-map ";" ":")
  :init (evil-collection-init)
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

(provide 'init-evil)

;;; init-evil.el ends here
