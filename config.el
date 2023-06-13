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
(setq doom-theme 'doom-one)

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
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "kj" 'evil-normal-state) ;; this is added by me
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

;; these keybindings are overriding some default keybindings
;; (define-key evil-normal-state-map (kbd "C-k") 'evil-window-increase-height)
;; (define-key evil-normal-state-map (kbd "C-j") 'evil-window-decrease-height)
;; (define-key evil-normal-state-map (kbd "C-l") 'evil-window-increase-width)
;; (define-key evil-normal-state-map (kbd "C-h") 'evil-window-decrease-width)


;; tree-sitter
;; (use-package tree-sitter
;;   :ensure t
;;   :config
;;   ;; activate tree-sitter on any buffer containing code for which it has a parser available
;;   (global-tree-sitter-mode)
;;   ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
;;   ;; by switching on and off
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package tree-sitter-langs
;;   :ensure t
;;   :after tree-sitter)
