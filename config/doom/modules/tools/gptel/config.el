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
                          :stream nil
                          :key key
                          :models '("mixtral-8x7b-32768"
                                    "gemma-7b-it"
                                    "llama2-70b-4096"))))
  )

(map! :after gptel
      :leader :prefix ("l" . "llm")
      :desc "Gptel" "g" #'gptel-menu
      :desc "Gptel send" "s" #'gptel-send
      :desc "Gptel system prompt" "p" #'gptel-system-prompt
      :desc "Gptel org set properties" "o" #'gptel-org-set-properties
      :desc "Gptel org set topic" "t" #'gptel-org-set-topic
      )

