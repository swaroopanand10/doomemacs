;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "swaroop"
      user-mail-address "swaroopanand695@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "Fira Code" :size 25 :weight 'semi-light)
     ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 15))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

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


;;setting font (make sure it is installed otherwise crashing will happen)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 18 :slant 'normal :weight 'normal))



;;custom keybindings

;;Exit insert mode by pressing k and then j quickly

(setq evil-escape-key-sequence nil)
;; (setq key-chord-two-keys-delay 0.1)
;; (key-chord-define evil-insert-state-map "kj" 'evil-normal-state) ;; this is added by me
;; (key-chord-define evil-insert-state-map "jk" 'evil-normal-state) ;; this is added by me
(key-chord-mode 1)

;; (map! :leader 
;;       :desc "toggling neotree"
;;       "e" #'neotree-toggle)


;; keybindings for switching and resizing windows and buffers
(global-set-key (kbd "M-h") 'evil-window-left)
(global-set-key (kbd "M-l") 'evil-window-right)
(global-set-key (kbd "M-k") 'evil-window-up)
(global-set-key (kbd "M-j") 'evil-window-down)

(global-set-key (kbd "C-S-k") 'evil-window-increase-height)
(global-set-key (kbd "C-S-j") 'evil-window-decrease-height)
(global-set-key (kbd "C-S-l") 'evil-window-increase-width)
(global-set-key (kbd "C-S-h") 'evil-window-decrease-width)

(global-set-key (kbd "M-H") '+evil/window-move-left)
(global-set-key (kbd "M-L") '+evil/window-move-right)
(global-set-key (kbd "M-K") '+evil/window-move-up)
(global-set-key (kbd "M-J") '+evil/window-move-down)


(define-key evil-normal-state-map (kbd "L") 'next-buffer)
(define-key evil-normal-state-map (kbd "H") 'previous-buffer)

;; lsp related
;; (define-key evil-normal-state-map (kbd "K") 'lsp-ui-doc-show)
;; (define-key evil-normal-state-map (kbd "J") 'lsp-ui-doc-hide)

(define-key evil-normal-state-map (kbd "J") 'lsp-ui-imenu)

;; these keybindings are overriding some default keybindings and not working
;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-increase-height)
;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-decrease-height)
;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-increase-width)
;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-decrease-width)

(defun my-jk ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?k)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        ;; timeout met
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      ;; timeout exceeded
      (insert initial-key))))

(define-key evil-insert-state-map (kbd "j") 'my-jk)

(defun my-kj ()
  (interactive)
  (let* ((initial-key ?k)
         (final-key ?j)
         (timeout 0.5)
         (event (read-event nil nil timeout)))
    (if event
        ;; timeout met
        (if (and (characterp event) (= event final-key))
            (evil-normal-state)
          (insert initial-key)
          (push event unread-command-events))
      ;; timeout exceeded
      (insert initial-key))))

(define-key evil-insert-state-map (kbd "k") 'my-kj)

;; tree-sitter
(use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
  ;; by switching on and off
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

;; always keep minimap-mode on
;; (minimap-mode t)


;; company settings
(setq company-idle-delay 0
      company-tooltip-idle-delay 0
      company-tooltip-maximum-width 80
      company-minimum-prefix-length 2
      company-require-match nil
      company-tooltip-align-annotations t
      company-tooltip-flip-when-above t
      company-frontends
      '(company-pseudo-tooltip-frontend
        company-preview-frontend
        company-echo-metadata-frontend))

;; (company-quickhelp-mode)
;; (setq company-quickhelp-delay 0)

;; (use-package lsp-ui
;;   :custom
;;   (lsp-ui-sideline-enable)
;;   (lsp-ui-doc-enable)
;;   (lsp-ui-doc-position 'bottom-and-right)
;;   :commands lsp-ui-mode)

 (use-package lsp-ui
    :hook (lsp-mode . lsp-ui-mode)
    :custom
    (lsp-ui-doc-position 'bottom))

;; (setq lsp-ui-sideline-show-diagnostics t
;;       ;; lsp-ui-sideline-show-hover t
;;       ;; lsp-ui-sideline-update-mode t
;;       ;; lsp-ui-sideline-delay 0
;;       lsp-ui-doc-enable t
;;       lsp-ui-doc-position 'bottom
;;       lsp-ui-doc-delay 0)

;; (tab-bar-mode)
;; never ask for closing emacs
(setq confirm-kill-emacs nil)


(defun my/company-show-doc-buffer ()
  "Temporarily show the documentation buffer for the selection."
  (interactive)
  (let* ((selected (nth company-selection company-candidates))
         (doc-buffer (or (company-call-backend 'doc-buffer selected)
                         (error "No documentation available"))))
    (with-current-buffer doc-buffer
      (goto-char (point-min)))
    (display-buffer doc-buffer t)))
;; it will open the doc buffer permenantly and we have to close it manually
(define-key evil-insert-state-map (kbd "C-<f1>") #'my/company-show-doc-buffer)

