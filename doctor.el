;;; tools/agent-shell/doctor.el -*- lexical-binding: t; -*-

(when (featurep! +claude)
  (unless (executable-find "claude-agent-acp")
    (warn! "claude-agent-acp not found in PATH\nInstall with: npm install -g @agentclientprotocol/claude-agent-acp"))
  (unless (executable-find "claude")
    (warn! "claude CLI not found in PATH\nInstall Claude Code and run 'claude' once to log in")))

(when (featurep! +gemini)
  (unless (executable-find "gemini")
    (warn! "gemini CLI not found in PATH\nInstall from: https://github.com/google-gemini/gemini-cli")))

(when (featurep! +codex)
  (unless (executable-find "codex-acp")
    (warn! "codex-acp not found in PATH\nInstall with: npm install -g @zed-industries/codex-acp")))

(when (featurep! +goose)
  (unless (executable-find "goose")
    (warn! "goose not found in PATH\nInstall from: https://block.github.io/goose/docs/getting-started/installation")))

(when (featurep! +mistral)
  (unless (executable-find "vibe-acp")
    (warn! "vibe-acp not found in PATH\nInstall with: uv tool install mistral-vibe")))

(when (featurep! +auggie)
  (unless (executable-find "auggie")
    (warn! "auggie not found in PATH\nInstall with: npm install -g @augmentcode/auggie")))

(when (featurep! +qwen)
  (unless (executable-find "qwen")
    (warn! "qwen not found in PATH\nInstall with: npm install -g @qwen-code/qwen-code@latest")))

(when (featurep! +cursor)
  (unless (executable-find "cursor-agent-acp")
    (warn! "cursor-agent-acp not found in PATH\nInstall with: npm install -g @blowmage/cursor-agent-acp")))

(when (featurep! +github)
  (unless (executable-find "copilot")
    (warn! "copilot CLI not found in PATH\nInstall GitHub Copilot CLI")))

(when (featurep! +opencode)
  (unless (executable-find "opencode")
    (warn! "opencode not found in PATH\nInstall from: https://opencode.ai")))

(when (featurep! +pool)
  (unless (executable-find "pool")
    (warn! "pool not found in PATH\nInstall from: https://poolside.ai/get-started\nAuthenticate with: pool login")))
