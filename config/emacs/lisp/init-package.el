;;; init-package.el --- Initialize package configurations

;;; Commentary:

;;; Code:

(provide 'init-package)

(require 'package)

;; TODO: make this a function
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("gnu-devel"   . "https://elpa.gnu.org/devel/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; Initialize packages
(unless (bound-and-true-p package--initialized) ; To avoid warnings in 27
  (setq package-enable-at-startup nil)          ; To prevent initializing twice
  (package-initialize))

                                        ; Setup `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Should set before loading `use-package'
(setq use-package-always-ensure t
      use-package-always-defer t
      use-package-expand-minimally t
      )

;; Required by `use-package'
(use-package diminish :ensure t)

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
