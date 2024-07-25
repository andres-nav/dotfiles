;;; $DOOMDIR/lisp/+keybindings.el -*- lexical-binding: t; -*-

(map!
 :map pdf-view-mode-map
 :gn "j" #'pdf-view-scroll-up-or-next-page
 :gn "J" #'pdf-view-next-line-or-next-page
 :gn "k" #'pdf-view-scroll-down-or-previous-page
 :gn "K" #'pdf-view-previous-line-or-previous-page
 :gn "h" #'pdf-view-previous-page-command
 :gn "l" #'pdf-view-next-page-command
 :gn "c" #'pdf-view-center-in-window
 )

(defun open-directory-fuzzy (directory)
  "Open the specified DIRECTORY with fuzzy search."
  (interactive "DDirectory: ")
  (let ((default-directory directory))
    (call-interactively #'find-file)))

(map! :leader
      :desc "Open MEGA inbox directory with fuzzy search" "f i" (lambda () (interactive) (open-directory-fuzzy "~/MEGA/0_inbox/"))
      :desc "Open MEGA brain directory with fuzzy search" "f b" (lambda () (interactive) (open-directory-fuzzy "~/MEGA/1_brain/"))
      :desc "Open /tmp directory with fuzzy search" "f t" (lambda () (interactive) (open-directory-fuzzy "/tmp/"))
      :desc "Open MEGA attachments directory with fuzzy search" "f a" (lambda () (interactive) (open-directory-fuzzy "~/MEGA/2_attachments/"))
      :desc "Open git directory with fuzzy search" "f g" (lambda () (interactive) (open-directory-fuzzy "~/git/")))
