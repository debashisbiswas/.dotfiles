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
(setq doom-font (font-spec :family "Iosevka" :size 20)
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 20))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'catppuccin)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


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
(setq scroll-margin 4)

(define-derived-mode heex-mode web-mode "HEEx" "Major mode for editing HEEx files")
(add-to-list 'auto-mode-alist '("\\.heex?\\'" . heex-mode))

(define-derived-mode astro-mode web-mode "Astro" "Major mode for editing Astro files")
(add-to-list 'auto-mode-alist '("\\.astro?\\'" . astro-mode))

(add-hook 'heex-mode-hook #'tree-sitter-hl-mode)
(add-hook 'heex-mode-hook (lambda() (tree-sitter-load 'heex)))

(add-hook 'markdown-mode-hook #'auto-fill-mode)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(setq projectile-project-search-path '("~/dev"))

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)
(remove-hook 'doom-first-input-hook #'evil-exchange)

;; rebind gx
;; https://github.com/emacs-evil/evil/blob/b7ab3840dbfc1da5f9ad56542fc94e3dab4be5f1/evil-maps.el#L84
(map! :n "gx" #'browse-url-at-point)

(use-package! gptel
  :config
  (gptel-make-ollama "Ollama"
    :host "localhost:11434"
    :stream t
    :models '("llama3.2:latest"))
  )

(setq org-log-done 'time)

(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))

(setq shell-file-name (executable-find "bash"))

(setq which-key-idle-secondary-delay 0)

;; obsidian.el

(require 'obsidian)
(obsidian-specify-path "~/maestoso/")
;; If you want a different directory of `obsidian-capture':
(setq obsidian-inbox-directory "Inbox")
;; Clicking on a wiki link referring a non-existing file the file can be
;; created in the inbox (t) or next to the file with the link (nil).
;; Default: t - creating in the inbox
                                        ;(setq obsidian-wiki-link-create-file-in-inbox nil)
;; You may want to define a folder for daily notes. By default it is the inbox.
                                        ;(setq obsidian-daily-notes-directory "Daily Notes")
;; Directory of note templates, unset (nil) by default
                                        ;(setq obsidian-templates-directory "Templates")
;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
                                        ;(setq obsidian-daily-note-template "Daily Note Template.md")


;; Define obsidian-mode bindings
(add-hook
 'obsidian-mode-hook
 (lambda ()
   ;; Replace standard command with Obsidian.el's in obsidian vault:
   (local-set-key (kbd "C-c C-o") 'obsidian-follow-link-at-point)

   ;; Use either `obsidian-insert-wikilink' or `obsidian-insert-link':
   (local-set-key (kbd "C-c C-l") 'obsidian-insert-wikilink)

   ;; Following backlinks
   (local-set-key (kbd "C-c C-b") 'obsidian-backlink-jump)))

;; Optionally you can also bind a few functions:
;; replace "YOUR_BINDING" with the key of your choice:
;; (global-set-key (kbd "YOUR_BINDING") 'obsidian-jump)       ;; Opening a note
;; (global-set-key (kbd "YOUR_BINDING") 'obsidian-capture)    ;; Capturing a new note in the inbox
;; (global-set-key (kbd "YOUR_BINDING") 'obsidian-daily-note) ;; Creating daily note

;; Activate detection of Obsidian vault
(global-obsidian-mode t)
