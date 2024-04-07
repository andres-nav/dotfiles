;;; tools/gptel/config.el -*- lexical-binding: t; -*-

(use-package! gptel
  :commands gptel gptel-menu gptel-mode gptel-send gptel-set-tpic
  :config
  (setq gptel-default-mode #'org-mode)

  (require 'auth-source)

  (let* ((auth-info (car (auth-source-search :user "groq")))
         (host (plist-get auth-info :host))
         (key (plist-get auth-info :secret)))

    (setq gptel-model   "mixtral-8x7b-32768"
          gptel-backend (gptel-make-openai "Groq"
                                           :host host
                                           :endpoint "/openai/v1/chat/completions"
                                           :stream t
                                           :key key
                                           :models '("mixtral-8x7b-32768"
                                                     "gemma-7b-it"
                                                     "llama2-70b-4096"))))
  )
