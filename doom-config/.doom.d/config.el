;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "zachary campbell")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Hack" :size 14)
      ;;doom-variable-pitch-font (font-spec :family "sans" :size 13)
      )
;;
;; (if (> (x-display-pixel-width) 1700)
;;    (setq doom-font (font-spec :family "Hack" :size 18))
;;   (setq doom-font (font-spec :family "Hack" :size 14)))

(setq exec-path (cons "usr/local/bin" exec-path))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function.
(use-package! modus-operandi-theme
  :ensure t
  :init
  ;; NOTE: Everything is disabled by default.
  (setq modus-operandi-theme-slanted-constructs t
        modus-operandi-theme-bold-constructs t
        modus-operandi-theme-fringes 'subtle ; {nil,'subtle,'intense}
        modus-operandi-theme-3d-modeline t
        modus-operandi-theme-faint-syntax t
        modus-operandi-theme-intense-hl-line t
        modus-operandi-theme-intense-paren-match t
        modus-operandi-theme-prompts 'subtle ; {nil,'subtle,'intense}
        modus-operandi-theme-completions 'moderate ; {nil,'moderate,'opinionated}
        modus-operandi-theme-diffs 'desaturated ; {nil,'desaturated,'fg-only}
        modus-operandi-theme-org-blocks 'greyscale ; {nil,'greyscale,'rainbow}
        modus-operandi-theme-variable-pitch-headings t
        modus-operandi-theme-rainbow-headings t
        modus-operandi-theme-section-headings t
        modus-operandi-theme-scale-headings t
        modus-operandi-theme-scale-1 1.05
        modus-operandi-theme-scale-2 1.1
        modus-operandi-theme-scale-3 1.15
        modus-operandi-theme-scale-4 1.2
        modus-operandi-theme-scale-5 1.3)
  :config
  (load-theme 'modus-operandi t))

(set-default 'truncate-lines nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "~/bin/plantuml.jar"))

(add-hook 'org-mode-hook '(lambda ()
                            (define-key org-mode-map
                              (kbd "M-<right>")
                              'org-demote)))

(add-hook 'after-init-hook 'org-agenda-list)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Haskell
(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-process-path-hie "haskell-language-server-wrapper")
  ;; Comment/uncomment this line to see interactions between lsp client/server.
  ;;(setq lsp-log-io t)
  )

(setq smtpmail-default-smtp-server "smtp.mailbox.org")

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-server "smtp.mailbox.org"
      smtpmail-auth-credentials (expand-file-name "~/.authinfo.gpg")
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465)

(require 'mu4e)
(setq mu4e-maildir "~/.mail"
      mu4e-attachment-dir "~/Downloads"
      mu4e-sent-folder "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder "/Trash")

(setq mail-user-agent 'mu4e-user-agent)
(setq user-mail-address "zcampbell@mailbox.org")
(setq mu4e-get-mail-command "mbsync mailbox"
      mu4e-change-filenames-when-moving t
      mu4e-update-interval 120)

;; Clojure mode hooks.............................................
(add-hook 'clojure-mode-hook
          '(lambda ()
	     (aggressive-indent-mode 1)
             (paredit-mode 1)
	     (yas-minor-mode 1) ;; for adding require/use/import
	     (define-key clojure-mode-map (kbd "C-o x")
	       'cider-eval-defun-at-point)
             (define-key clojure-mode-map (kbd "C-o j") 'cider-jack-in)
             (define-key clojure-mode-map (kbd "C-o J")
               (lambda () (interactive) (cider-quit) (cider-jack-in)))
             (define-key clojure-mode-map (kbd "C-c e") 'cider-pprint-eval-last-sexp-to-repl)

	     (define-key clojure-mode-map (kbd "C-o C") 'convert-selection-to-code)
             (define-key clojure-mode-map (kbd "C-<up>") 'paredit-backward)
             (define-key clojure-mode-map (kbd "C-<down>") 'paredit-forward)
             (define-key clojure-mode-map (kbd "C-o y")
               (lambda ()
	         (interactive)
	         (insert "\n;;=>\n'")
	         (cider-eval-last-sexp 't)))
	     (define-key clojure-mode-map (kbd "C-o Y")
	       (lambda ()
	         (interactive)
	         (cider-pprint-eval-last-sexp)))
             (define-key clojure-mode-map (kbd "C-o C-i")
               (lambda ()
                 (interactive)
                 (cider-auto-test-mode 1)))))

(after! clojure-mode
  (define-clojure-indent
    (PUT 2)
    (POST 2)
    (PATCH 2)
    (DELETE 2)
    (GET 2)
    (addtest 1)
    (are 1)
    (context 2)
    (defsystest 1)
    (lz-post-lead 2)
    (pending 1)
    (route-middleware 1)
    (routes 0)))

(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-repl-display-in-current-window t)
(setq cider-repl-result-prefix ";; => ")

;; Treemacs
(use-package! all-the-icons
  :defer t)
(use-package! treemacs-persp
  ;;:defer t
  :when (featurep! :ui workspaces)
  :after (treemacs persp-mode)
  :config
  (treemacs-set-scope-type 'Perspectives))

(after! treemacs
  (defun +treemacs--init ()
    (require 'treemacs)
    (let ((origin-buffer (current-buffer)))
      (cl-letf (((symbol-function 'treemacs-workspace->is-empty?)
                 (symbol-function 'ignore)))
        (treemacs--init))
      (unless (bound-and-true-p persp-mode)
        (dolist (project (treemacs-workspace->projects (treemacs-current-workspace)))
          (treemacs-do-remove-project-from-workspace project)))
      (with-current-buffer origin-buffer
        (let ((project-root (or (doom-project-root) default-directory)))
          (treemacs-do-add-project-to-workspace
           (treemacs--canonical-path project-root)
           (doom-project-name project-root)))
        (setq treemacs--ready-to-follow t)
        (when (or treemacs-follow-after-init treemacs-follow-mode)
          (treemacs--follow))))))

;; Elfeed
(use-package! elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/org/elfeed.org")))

(defun bjm/elfeed-show-all ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-all"))

(defun bjm/elfeed-show-emacs ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-emacs"))

(defun bjm/elfeed-show-other ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-other"))

(defun bjm/elfeed-show-daily ()
  (interactive)
  (bookmark-maybe-load-default-file)
  (bookmark-jump "elfeed-daily"))

(use-package! elfeed
  :ensure t
  :bind (:map elfeed-search-mode-map
         ("A" . bjm/elfeed-show-all)
         ("E" . bjm/elfeed-show-emacs)
         ("D" . bjm/elfeed-show-daily)
         ("O" . bjm/elfeed-show-other)
         ("q" . bjm/elfeed-save-db-and-bury)))

;;functions to support syncing .elfeed between machines
;;makes sure elfeed reads index from disk before launching
(defun bjm/elfeed-load-db-and-open ()
  "Wrapper to load the elfeed db from disk before opening"
  (interactive)
  (elfeed-db-load)
  (elfeed)
  (elfeed-search-update--force))

;;write to disk when quiting
(defun bjm/elfeed-save-db-and-bury ()
  "Wrapper to save the elfeed db to disk before burying buffer"
  (interactive)
  (elfeed-db-save)
  (quit-window))

(global-set-key (kbd "C-x w") 'bjm/elfeed-load-db-and-open)
(global-set-key (kbd "C-x e") 'elfeed)

;; Cider setup................................................
;;
(add-hook 'cider-mode-hook #'eldoc-mode)
;; (setq cider-auto-select-error-buffer nil)
;; (setq cider-repl-pop-to-buffer-on-connect nil)
;; (setq cider-interactive-eval-result-prefix ";; => ")

(global-unset-key "\C-a")
(global-unset-key (kbd "C-q"))
(global-set-key [?\C- ] 'other-window)
(global-set-key (kbd "C-SPC") 'other-window)
(global-set-key (kbd "C-v") 'undo)
(global-set-key "\C-a" 'beginning-of-line-text)
(global-set-key "\C-q" 'set-mark-command)
;;(global-set-key "\C-oK" 'helm-show-kill-ring)
;; (global-set-key "\C-cH" 'highlight-long-lines)
;; (global-set-key "\C-ch" 'unhighlight-long-lines)

;; Multiple cursors
(global-set-key (kbd "C-c m c") 'mc/edit-lines)
(global-set-key (kbd "C-c m l") 'mc/mark-all-like-this)
(global-set-key (kbd "C-c m r") 'mc/mark-all-in-region)
(global-set-key (kbd "C-c m n") 'mc/mark-next-word-like-this)
(global-set-key (kbd "C-c m s") 'mc/mark-next-like-this)

;; Show trailing whitespace, `cause we hates it....
(setq-default show-trailing-whitespace t)

;; Resizing
(setq frame-resize-pixelwise t)
(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the middle"
  (let* ((win-edges (window-edges))
	       (this-window-y-min (nth 1 win-edges))
	       (this-window-y-max (nth 3 win-edges))
	       (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the middle"
  (let* ((win-edges (window-edges))
	       (this-window-x-min (nth 0 win-edges))
	       (this-window-x-max (nth 2 win-edges))
	       (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -10))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 10))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -10))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 10))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -10))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 10))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally -10))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally 10))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally -10))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right)) (enlarge-window-horizontally 10))
   ((equal "right" (win-resize-left-or-right)) (enlarge-window-horizontally -10))
   ((equal "mid" (win-resize-left-or-right)) (enlarge-window-horizontally 10))))

(global-set-key (kbd "C-c C-<right>") 'win-resize-minimize-vert)
(global-set-key (kbd "C-c C-<up>") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-c C-<left>") 'win-resize-minimize-horiz)
(global-set-key (kbd "C-c C-<right>") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-c C-<up>") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-c C-<down>") 'win-resize-minimize-horiz)
(global-set-key (kbd "C-c C-<left>") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-c C-<right>") 'win-resize-minimize-vert)

(global-set-key (kbd "C-c m m") 'mu4e)
(global-set-key (kbd "C-n") 'forward-word)
(global-set-key (kbd "C-p") 'delete-indentation)

;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (paredit-mode 1)
	    (aggressive-indent-mode 1)))

;; Projectile
;;
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-completion-system 'ivy)

;; Default directory
;;(setq default-directory "~/dev/")

;; Don't lint my emacs config
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
