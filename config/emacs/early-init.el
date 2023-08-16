;;; early-init.el --- emacs first loaded config
;;; Commentary:

;;; Code:

(setq
 ;; Do not make installed packages available when Emacs starts
 package-enable-at-startup nil
 ;; HACK: Increase the garbage collection (GC) threshold for faster startup.
 ;; This will be overwritten when `gcmh-mode' (a.k.a. the Garbage Collector
 ;; Magic Hack) gets loaded in the `me-gc' module (see "init.el").
 gc-cons-threshold most-positive-fixnum
 ;; Prefer loading the newer version of files
 load-prefer-newer noninteractive
 ;; Inhibit resizing frame
 frame-inhibit-implied-resize t
 ;; Remove some unneeded UI elements
 default-frame-alist '((tool-bar-lines . 0)
                       (menu-bar-lines . 0)
                       (vertical-scroll-bars)
                       (horizontal-scroll-bars)
                       ;; (mouse-color . "yellow")
                       ;; (left-fringe . 8)
                       ;; (right-fringe . 13)
                       (fullscreen . maximized))
 ;; Explicitly set modes disabled in `default-frame-alist' to nil
 tool-bar-mode nil
 menu-bar-mode nil
 scroll-bar-mode nil
 )

;; Custom var file
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Prevent flashing of unstyled modeline at startup
(setq-default mode-line-format nil)


;;; early-init.el ends here
