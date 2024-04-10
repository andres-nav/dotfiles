;;; $DOOMDIR/lisp/+ai.el -*- lexical-binding: t; -*-

(after! gptel
  ;; Prompts
  ;;https://github.com/friuns2/BlackFriday-GPTs-Prompts
  ;;https://github.com/ai-boost/awesome-prompts/
  ;; (add-to-list 'gptel-directives '(scala . "")
  ;;              )

  (gptel--system-message)

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

  (let* ((host "api.together.xyz")
         (user "togetherai")
         )
    (gptel-make-openai user
      :host host
      :key (gptel-api-key-from-auth-source host user)
      :stream t
      :models '(;; has many more, check together.ai
                "mistralai/Mixtral-8x22B" ;; super big boy
                "databricks/dbrx-instruct" ;; really big model
                "deepseek-ai/deepseek-llm-67b-chat"
                "togethercomputer/evo-1-131k-base"
                "NousResearch/Nous-Hermes-2-Mixtral-8x7B-SFT"
                "Qwen/Qwen1.5-72B-Chat"
                "meta-llama/Llama-2-70b-chat-hf"
                "codellama/CodeLlama-34b-Python-hf"
                "Phind/Phind-CodeLlama-34B-v2"
                ))
    )
  )
