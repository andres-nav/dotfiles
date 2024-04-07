;;; $DOOMDIR/lisp/modeline.el -*- lexical-binding: t; -*-

(defun doom-modeline-conditional-buffer-encoding ()
  "We expect the encoding to be LF UTF-8, only show the modeline when this is not."
  (setq-local doom-modeline-buffer-encoding
              (unless (and (memq (plist-get (coding-system-plist buffer-file-coding-system) :category)
                                 '(coding-category-undecided coding-category-utf-8))
                           (not (memq (coding-system-eol-type buffer-file-coding-system) '(1 2))))
                t)))

(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)
