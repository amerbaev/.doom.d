;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Arseny Amerbaev"
      user-mail-address "amerbaev@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two
(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Code" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

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

(setq default-input-method "russian-computer")
(setq calendar-week-start-day 1)

(use-package! centaur-tabs
  :init
  (setq centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-bar 'left
        centaur-tabs-set-modified-marker t
        centaur-tabs-close-button "✕"
        centaur-tabs-modified-marker "•"
        ;; Scrolling (with the mouse wheel) past the end of the tab list
        ;; replaces the tab list with that of another Doom workspace. This
        ;; prevents that.
        centaur-tabs-cycle-scope 'tabs)

  :config
  (add-hook '+doom-dashboard-mode-hook #'centaur-tabs-local-mode)
  (add-hook '+popup-buffer-mode-hook #'centaur-tabs-local-mode)
  (setq centaur-tabs-style "bar"
	  centaur-tabs-height 32
	  centaur-tabs-set-icons t
	  centaur-tabs-set-modified-marker t
	  centaur-tabs-show-navigation-buttons t
	  centaur-tabs-set-bar 'under
	  x-underline-at-descent-line t)
   (centaur-tabs-headline-match)
   ;; (setq centaur-tabs-gray-out-icons 'buffer)
   ;; (centaur-tabs-enable-buffer-reordering)
   ;; (setq centaur-tabs-adjust-buffer-order t)
   (centaur-tabs-mode t)
   (setq uniquify-separator "/")
   (setq uniquify-buffer-name-style 'forward)
   (defun centaur-tabs-buffer-groups ()
     "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
     (list
      (cond
	((derived-mode-p 'prog-mode)
	 "Editing")
	((derived-mode-p 'dired-mode)
	 "Dired")
	((memq major-mode '(helpful-mode
			    help-mode))
	 "Help")
	((memq major-mode '(org-mode
			    org-agenda-clockreport-mode
			    org-src-mode
			    org-agenda-mode
			    org-beamer-mode
			    org-indent-mode
			    org-bullets-mode
			    org-cdlatex-mode
			    org-agenda-log-mode
			    diary-mode))
	 "OrgMode")
        ((memq major-mode `(telega-root-mode
                            telega-chat-mode
                            telega-image-mode))
         "Telega")
	(t
	 (centaur-tabs-get-group-name (current-buffer)))))))
