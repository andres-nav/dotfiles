;;; init-package.el --- Initialize package configurations

;;; Commentary:

;;; Code:

(provide 'init-package)

(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
	("gnu-devel"   . "https://elpa.gnu.org/devel/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/")))

;; Initialize packages
(unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

;; Setup `use-package'
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
(straight-use-package 'use-package)

;; Should set before loading `use-package'
(eval-and-compile
  (setq use-package-always-ensure t
	use-package-always-defer t
	use-package-expand-minimally t
	))

(eval-when-compile
  (require 'use-package))

;; Required by `use-package'
(use-package diminish)

;; Update GPG keyring for GNU ELPA
(use-package gnu-elpa-keyring-update)

;; Update packages
;; (unless (fboundp 'package-upgrade-all)
;;   (use-package auto-package-update
;;     :init
;;     (setq auto-package-update-delete-old-versions t
;;           auto-package-update-hide-results t)
;;     (defalias 'package-upgrade-all #'auto-package-update-now)))

(provide 'init-package)

;;; init-package.el ends here
