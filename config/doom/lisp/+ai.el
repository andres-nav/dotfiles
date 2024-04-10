;;; $DOOMDIR/lisp/+ai.el -*- lexical-binding: t; -*-

(after! gptel
  ;; (require 'auth-source)

  (let* ((auth-info (car (auth-source-search :user "groq")))
         (host (plist-get auth-info :host))
         (key (plist-get auth-info :secret)))

    (setq gptel-model   "mixtral-8x7b-32768"
          gptel-backend
          (gptel-make-openai "Groq"
            :host host
            :key key
            :endpoint "/openai/v1/chat/completions"
            :stream t
            :models '("mixtral-8x7b-32768"
                      "gemma-7b-it"
                      "llama2-70b-4096"))
          )
    )

  (let* ((auth-info (car (auth-source-search :user "kagi")))
         (host (plist-get auth-info :host))
         (key (plist-get auth-info :secret)))
    (gptel-make-kagi "Kagi"
      :key key
      )
    )

  (let* ((auth-info (car (auth-source-search :user "togetherai")))
         (host (plist-get auth-info :host))
         (key (plist-get auth-info :secret)))
    (gptel-make-openai "TogetherAI"
      :host host
      :key key
      :stream t
      :models '(;; has many more, check together.ai
                "mistralai/Mixtral-8x7B-Instruct-v0.1"
                "codellama/CodeLlama-70b-hf"
                "allenai/OLMo-7B-Twin-2T"
                "stabilityai/stable-diffusion-2-1"
                "stabilityai/stable-diffusion-xl-base-1.0"
                ))
    )
  )
