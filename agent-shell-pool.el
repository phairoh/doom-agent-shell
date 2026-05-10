;;; agent-shell-pool.el --- Poolside pool agent configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Poolside pool agent support for agent-shell.
;; Requires pool CLI: https://poolside.ai/get-started
;; Authenticate with: pool login

;;; Code:

(eval-when-compile
  (require 'cl-lib))
(require 'shell-maker)
(require 'acp)

(declare-function agent-shell--indent-string "agent-shell")
(declare-function agent-shell-make-agent-config "agent-shell")
(autoload 'agent-shell-make-agent-config "agent-shell")
(declare-function agent-shell--make-acp-client "agent-shell")
(declare-function agent-shell--dwim "agent-shell")

(defcustom agent-shell-pool-acp-command
  '("pool" "acp")
  "Command and parameters for the Pool client.

The first element is the command name, and the rest are command parameters."
  :type '(repeat string)
  :group 'agent-shell)

(defcustom agent-shell-pool-environment
  nil
  "Environment variables for the Pool client.

Example:

  (setq agent-shell-pool-environment
        (agent-shell-make-environment-variables
         \"MY_VAR\" \"some-value\"))"
  :type '(repeat string)
  :group 'agent-shell)

(defun agent-shell-pool-make-config ()
  "Create a Pool agent configuration."
  (agent-shell-make-agent-config
   :identifier 'pool
   :mode-line-name "Pool"
   :buffer-name "Pool"
   :shell-prompt "Pool> "
   :shell-prompt-regexp "Pool> "
   :welcome-function #'agent-shell-pool--welcome-message
   :client-maker (lambda (buffer)
                   (agent-shell-pool-make-client :buffer buffer))
   :install-instructions "See https://poolside.ai/get-started\nAuthenticate with: pool login"))

(defun agent-shell-pool-start-agent ()
  "Start an interactive Pool agent shell."
  (interactive)
  (agent-shell--dwim :config (agent-shell-pool-make-config)
                     :new-shell t))

(cl-defun agent-shell-pool-make-client (&key buffer)
  "Create a Pool ACP client with BUFFER as context."
  (unless buffer
    (error "Missing required argument: :buffer"))
  (agent-shell--make-acp-client :command (car agent-shell-pool-acp-command)
                                :command-params (cdr agent-shell-pool-acp-command)
                                :environment-variables agent-shell-pool-environment
                                :context-buffer buffer))

(defun agent-shell-pool--welcome-message (config)
  "Return Pool welcome message using shell-maker CONFIG."
  (let ((art (agent-shell--indent-string 4 (agent-shell-pool--ascii-art)))
        (message (string-trim-left (shell-maker-welcome-message config) "\n")))
    (concat "\n\n" art "\n\n" message)))

(defun agent-shell-pool--ascii-art ()
  "Pool ASCII art."
  (let ((is-dark (eq (frame-parameter nil 'background-mode) 'dark)))
    (propertize
     "█▀█ █▀█ █▀█ █░░
█▀▀ █▄█ █▄█ █▄▄"
     'font-lock-face (if is-dark
                         '(:foreground "#a0a0a0" :inherit fixed-pitch)
                       '(:foreground "#505050" :inherit fixed-pitch)))))

(provide 'agent-shell-pool)

;;; agent-shell-pool.el ends here
