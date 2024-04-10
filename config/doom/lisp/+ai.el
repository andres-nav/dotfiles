;;; $DOOMDIR/lisp/+ai.el -*- lexical-binding: t; -*-

(after! gptel
  ;; Prompts
  ;;https://github.com/friuns2/BlackFriday-GPTs-Prompts
  ;;https://github.com/ai-boost/awesome-prompts/
  ;; (add-to-list 'gptel-directives '(scala . "")
  ;;              )


  (setq! gptel-model   "mixtral-8x7b-32768"
         gptel-backend
         (let* ((host "api.groq.com")
                (user "groq")
                )
           (gptel-make-openai user
             :host host
             :key (gptel-api-key-from-auth-source host user)
             :endpoint "/openai/v1/chat/completions"
             :stream t
             :models '("mixtral-8x7b-32768"
                       "gemma-7b-it"
                       "llama2-70b-4096"))
           )
         )

  (let* ((host "kagi.com")
         (user "kagi")
         )
    (gptel-make-kagi user
      :key (gptel-api-key-from-auth-source host user)
      )
    )

  (let* ((host "api.together.xyz")
         (user "togetherai")
         )
    (gptel-make-openai user
      :host host
      :key (gptel-api-key-from-auth-source host user)
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
