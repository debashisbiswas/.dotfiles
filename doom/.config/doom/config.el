;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(let ((font-size (if (string= (getenv "IS_WORK_MACHINE") "true") 18 20)))
  (setq doom-font (font-spec :family "Iosevka Term" :size font-size :weight 'normal)
        doom-variable-pitch-font (font-spec :family "Noto Sans" :size font-size)))

(unless (string= (getenv "IS_WORK_MACHINE") "true")
  (doom/set-frame-opacity 95))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-vivendi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-log-done 'time)

(let ((orgdir "~/org/"))
  (setq org-directory orgdir)
  (when (file-exists-p orgdir)
    (setq org-agenda-files (directory-files-recursively orgdir "\\.org$"))))

(after! org-mode (add-to-list 'org-agenda-custom-commands
                              '("d" "Done items from past week"
                                tags
                                "+CLOSED>=\"<-7d>\""
                                ((org-agenda-sorting-strategy '(schedule-up))))
                              t))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'json)

;; (setq scroll-margin 4)
(map! :desc "dired" :n "-" #'dired-jump)

(define-derived-mode heex-mode web-mode "HEEx" "Major mode for editing HEEx files")
(add-to-list 'auto-mode-alist '("\\.heex?\\'" . heex-mode))

(define-derived-mode astro-mode web-mode "Astro" "Major mode for editing Astro files")
(add-to-list 'auto-mode-alist '("\\.astro?\\'" . astro-mode))

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(remove-hook 'doom-first-input-hook #'evil-exchange)
(add-hook 'heex-mode-hook #'tree-sitter-hl-mode)
(add-hook 'heex-mode-hook (lambda() (tree-sitter-load 'heex)))
(add-hook 'markdown-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq projectile-project-search-path '(("~/dev" . 1) ("~/personal" . 1)))

;; rebind gx
;; https://github.com/emacs-evil/evil/blob/b7ab3840dbfc1da5f9ad56542fc94e3dab4be5f1/evil-maps.el#L84
(map! :n "gx" #'browse-url-at-point)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(when (require 'plsql nil 'noerror)
  (setq auto-mode-alist
        (append
         '(("\\.pkb\\'" . plsql-mode)
           ("\\.pks\\'" . plsql-mode)
           ("\\.fnc\\'" . plsql-mode)
           ("\\.vw\\'" . plsql-mode)
           ("\\.sql\\'" . plsql-mode))
         auto-mode-alist)))

(defun build-doppler-command (project secret)
  (concat "doppler secrets --project \"" project "\" get \"" secret "\" --plain"))

(defun get-anthropic-key-from-doppler ()
  (string-trim (shell-command-to-string (build-doppler-command "system" "ANTHROPIC_API_KEY"))))

(use-package! gptel
  :config
  (setq
   gptel-model 'qwen2.5-coder:7b
   gptel-backend (gptel-make-ollama "Ollama"
                   :host "localhost:11434"
                   :stream t
                   :models '(qwen2.5-coder:7b llama3.2:latest)))

  (let ((anthropic-api-key (get-anthropic-key-from-doppler)))
    (gptel-make-anthropic "Claude"
      :stream t
      :key anthropic-api-key)))


(setq shell-file-name (executable-find "bash"))

(let ((fish (executable-find "fish")))
  (setq-default vterm-shell fish)
  (setq-default explicit-shell-file-name fish))

(setq which-key-idle-secondary-delay 0)

;; https://gist.github.com/yorickvP/6132f237fbc289a45c808d8d75e0e1fb
(when (string= (getenv "IS_WORK_MACHINE") "true")
  (setq wl-copy-process nil)
  (defun wl-copy (text)
    (setq wl-copy-process (make-process :name "wl-copy"
                                        :buffer nil
                                        :command '("wl-copy" "-f" "-n")
                                        :connection-type 'pipe))
    (process-send-string wl-copy-process text)
    (process-send-eof wl-copy-process))
  (defun wl-paste ()
    (if (and wl-copy-process (process-live-p wl-copy-process))
        nil ; should return nil if we're the current paste owner
      (shell-command-to-string "wl-paste -n | tr -d \r")))
  (setq interprogram-cut-function 'wl-copy)
  (setq interprogram-paste-function 'wl-paste))

(use-package! mixed-pitch
  :hook
  (markdown-mode . mixed-pitch-mode))

(defun violet/sudocompile (command)
  (let ((default-directory "/sudo::/"))
    (compile command)))

(defun violet/on-wsl ()
  (when (executable-find "uname")
    (string-match-p "microsoft" (shell-command-to-string "uname -r"))))

(defun violet/rebuild-system ()
  (interactive)
  (let* ((dotfiles (getenv "DOTFILES"))
         (args (format "--flake \"%s/nixos#%s\" switch" dotfiles (system-name))))
    (cond ((eq system-type 'darwin) (violet/sudocompile (format "darwin-rebuild %s" args)))
          ((violet/on-wsl) (compile (format "home-manager %s" args)))
          (t (violet/sudocompile (format "nixos-rebuild %s" args))))
    (with-current-buffer "*compilation*"
      (setq-local compilation-finish-functions
                  (list (lambda (buffer status)
                          (when (string-match-p "finished" status)
                            (kill-buffer buffer)
                            (message "System successfully rebuilt!"))))))
    (select-window (get-buffer-window "*compilation*"))))

(map! :leader :desc "Rebuild system" :n "s r" #'violet/rebuild-system)

(after! lua-mode
  ;; From the stylua README:
  ;; ---------------------------------------------------------------------------
  ;; The CLI looks for a stylua.toml or .stylua.toml starting from the directory
  ;; of the file being formatted. It will keep searching upwards until it
  ;; reaches the current directory where the tool was executed. If not found, we
  ;; search for an .editorconfig file, otherwise fall back to the default
  ;; configuration. This feature can be disabled using --no-editorconfig. See
  ;; EditorConfig for more details.
  ;;
  ;; By default, StyLua does not search further than the current directory. Use
  ;; --search-parent-directories to recursively search parent directories. This
  ;; will keep searching ancestors and, if not found, will then look in
  ;; $XDG_CONFIG_HOME / $XDG_CONFIG_HOME/stylua / $HOME/.config and
  ;; $HOME/.config/stylua.
  ;; ---------------------------------------------------------------------------
  ;;
  ;; The important note here is that stylua's default is to look upwards *until
  ;; the directory from which stylua was executed (cwd)*, rather than until the
  ;; file's path! Apheleia isn't executing the formatter from the project root,
  ;; so if we want the project config, we need to explicity ask stylua to look
  ;; upwards from the file to find it.
  ;;
  ;; Apheleia includes apheleia-from-project-root which can help with this, but
  ;; I'd rather use the tool's builtin behavior to avoid having to handle every
  ;; case of stylua.toml, .stylua.toml, .editorconfig, etc
  (set-formatter!
    'stylua '("stylua" "--search-parent-directories" "-")
    :modes '(lua-mode)))
