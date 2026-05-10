;;; tools/agent-shell/config.el -*- lexical-binding: t; -*-

(require 'acp)
(require 'agent-shell)
(load! "agent-shell-pool")

(use-package! agent-shell
  :config
  (setq agent-shell-thought-process-expand-by-default t)
  (add-to-list 'agent-shell-agent-configs (agent-shell-pool-make-config) t)

  (cond
   ((featurep! +claude)
    (setq agent-shell-preferred-agent-config
          (agent-shell-anthropic-make-claude-code-config)))
   ((featurep! +gemini)
    (setq agent-shell-preferred-agent-config
          (agent-shell-google-make-gemini-config)))
   ((featurep! +codex)
    (setq agent-shell-preferred-agent-config
          (agent-shell-openai-make-codex-config)))
   ((featurep! +goose)
    (setq agent-shell-preferred-agent-config
          (agent-shell-goose-make-agent-config)))
   ((featurep! +mistral)
    (setq agent-shell-preferred-agent-config
          (agent-shell-mistral-make-config)))
   ((featurep! +auggie)
    (setq agent-shell-preferred-agent-config
          (agent-shell-auggie-make-agent-config)))
   ((featurep! +qwen)
    (setq agent-shell-preferred-agent-config
          (agent-shell-qwen-make-agent-config)))
   ((featurep! +cursor)
    (setq agent-shell-preferred-agent-config
          (agent-shell-cursor-make-agent-config)))
   ((featurep! +github)
    (setq agent-shell-preferred-agent-config
          (agent-shell-github-make-copilot-config)))
   ((featurep! +opencode)
    (setq agent-shell-preferred-agent-config
          (agent-shell-opencode-make-agent-config)))
   ((featurep! +pool)
    (setq agent-shell-preferred-agent-config
          (agent-shell-pool-make-config))))

  (when (featurep! :editor evil)
    (evil-define-key 'insert agent-shell-mode-map (kbd "RET") #'newline)
    (evil-define-key 'normal agent-shell-mode-map (kbd "RET") #'comint-send-input)
    (add-hook 'diff-mode-hook
              (lambda ()
                (when (string-match-p "\\*agent-shell-diff\\*" (buffer-name))
                  (evil-emacs-state)))))

  (map! :leader
        (:prefix ("A" . "agent")
         :desc "Open agent shell"   "a" #'agent-shell
         :desc "New agent shell"    "n" #'agent-shell-new-shell
         :desc "Toggle shell"       "t" #'agent-shell-toggle
         :desc "Send region/error"  "s" #'agent-shell-send-dwim
         :desc "Send file"          "f" #'agent-shell-send-current-file
         :desc "Compose prompt"     "c" #'agent-shell-prompt-compose
         :desc "Clipboard image"    "i" #'agent-shell-send-clipboard-image)))
