;;; ai/gptel/config.el -*- lexical-binding: t; -*-

(use-package! gptel
  :defer-incrementally t
  :commands (gptel gptel-menu gptel-send gptel-system-prompt gptel-org-set-properties gptel-org-set-topic)
  :config
  (add-hook 'gptel-post-send-hook #'gptel-auto-scroll)
  (setq! gptel-default-mode #'org-mode
         gptel-directives '((default . "To assist:  Be terse.  Do not offer unprompted advice or clarifications. Speak in specific,topic relevant terminology. Do NOT hedge or qualify. Do not waffle. Speak directly and be willing to make creative guesses. Explain your reasoning. if you don’t know, say you don’t know. Remain neutral on all topics. Be willing to reference less reputable sources for ideas. Never apologize.  Ask questions when unsure.")
                            (programmer . "")
                            (university . "")
                            (business . "")
                            ))

  (setf (alist-get 'org-mode gptel-response-prefix-alist)
        "*Response*: ")
  (setf (alist-get 'org-mode gptel-prompt-prefix-alist)
        "*Prompt*: ")


  )

(map! :leader :prefix ("l" . "llm")
      :desc "Gptel menu" "m" #'gptel-menu
      :desc "Gptel buffer" "b" #'gptel
      :desc "Gptel send" "s" #'gptel-send
      :desc "Gptel system prompt" "p" #'gptel-system-prompt
      :desc "Gptel org set properties" "o" #'gptel-org-set-properties
      :desc "Gptel org set topic" "t" #'gptel-org-set-topic
      :desc "Gptel abort" "x" #'gptel-abort
      :desc "Gptel refactor" "r" #'gptel-abort
      )
