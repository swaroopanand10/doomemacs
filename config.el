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
(setq doom-theme 'doom-moonlight)

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

(map! :leader 
      :desc "toggle neotree"
      "oo" #'neotree-toggle)


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

;; (global-set-key (kbd "L") 'next-buffer)
;; (global-set-key (kbd "H") 'previous-buffer)

(define-key evil-normal-state-map (kbd "J") 'lsp-ui-imenu)

(defun my-jk ()
  (interactive)
  (let* ((initial-key ?j)
         (final-key ?k)
         (timeout 0.1)
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
         (timeout 0.1)
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


;; always keep minimap-mode on
;; (minimap-mode t)


;; company settings
(setq company-idle-delay 0.1
      ;; company-tooltip-idle-delay 0
      ;; company-tooltip-maximum-width 80
      company-minimum-prefix-length 1
      ;; company-require-match nil
      ;; company-tooltip-align-annotations t
      ;; company-tooltip-flip-when-above t
      company-show-numbers t
      company-frontends
      '(company-pseudo-tooltip-frontend
        company-preview-frontend
        company-echo-metadata-frontend))

;; (company-quickhelp-mode)
;; (setq company-quickhelp-delay 0)

;; (use-package lsp-ui)
;;   (setq lsp-ui-doc-enable t)
;;   ;; (setq lsp-ui-doc-show-with-cursor t)
;;   (setq lsp-ui-doc-show-with-mouse t)

(after! lsp-ui
        (setq lsp-ui-doc-enable t)
        (setq lsp-ui-doc-show-with-mouse t)
       (setq lsp-ui-doc-max-height 100)
        (setq lsp-ui-doc-max-width 200))

(setq lsp-modeline-code-actions-mode t)
;; (after! lsp-mode
;; (add-hook 'after-init-hook 'company-tng-mode)) ;; it was activated properly but then the snippets were not working


;; (setq lsp-ui-sideline-show-diagnostics t
;;       ;; lsp-ui-sideline-show-hover t
;;       ;; lsp-ui-sideline-update-mode t
;;       ;; lsp-ui-sideline-delay 0
;;       lsp-ui-doc-enable t
;;       lsp-ui-doc-position 'bottom)

;; if want to disable auto-completion
;; (after! company
;;   (setq company-idle-delay nil))

;; never ask for closing emacs
(setq confirm-kill-emacs nil)

;; to avoid the which key being covered by status line
(setq which-key-allow-imprecise-window-fit nil)

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
;; (define-key evil-insert-state-map (kbd "C-o") #'my/company-show-doc-buffer)
;; (define-key evil-insert-state-map (kbd "C-o") evil-emacs-state)


;; setting compnay backends
;; (after! prog (set-company-backend! 'prog-mode 'company-capf 'company-yasnippet 'company-files 'company-dabbrev))
;; (after! text (set-company-backend! 'text-mode 'company-files 'company-dabbrev))
;; (after! eshell (set-company-backend! 'text-mode 'company-files 'company-dabbrev))
;; (after! conf (set-company-backend! 'conf-mode 'company-capf 'company-files 'company-dabbrev 'company-yasnippet))
;; (after! c++ (set-company-backend! 'c++-mode 'company-capf 'company-files 'company-dabbrev 'company-yasnippet))

;; (after! text
;;   (set-company-backend! 'text-mode
;;     '(company-files company-dabbrev))

  ;; (set-company-backend! 'text-mode
  ;;   'company-capf 'company-files 'company-dabbrev 'company-yasnippet)

  ;; (set-company-backend! 'fundamental-mode
  ;;   'company-capf 'company-files 'company-dabbrev 'company-yasnippet)

  ;; (set-company-backend! 'conf-mode
  ;;    'company-capf 'company-dabbrev 'company-files 'company-yasnippet)

  ;; (set-company-backend! 'prog-mode
  ;;    'company-capf 'company-yasnippet 'company-dabbrev 'company-files)

  ;; (set-company-backend! '(c-mode c++-mode rjsx-mode python-mode rust-mode)
  ;;    'company-capf 'company-yasnippet 'company-dabbrev 'company-files)
;; (setq-hook! 'text-mode-hook +lsp-company-backends '(company-capf company-dabbrev company-dabbrev-code company-files company-yasnippet))
;; (setq-hook! 'conf-mode-hook +lsp-company-backends '(company-capf company-yasnippet company-dabbrev company-dabbrev-code company-files))
;; (setq-hook! 'prog-mode-hook +lsp-company-backends '(company-capf company-yasnippet company-dabbrev company-dabbrev-code company-files))

;; (setq-hook! 'c++-mode-hook +lsp-company-backends '(:seperate company-capf company-yasnippet company-dabbrev company-dabbrev-code )) ;; messing with the snippet order
;; (setq-hook! 'c-mode-hook +lsp-company-backends '(company-yasnippet company-capf company-dabbrev company-dabbrev-code company-files))
;; (setq-hook! 'rjsx-mode-hook +lsp-company-backends '(company-capf company-yasnippet company-dabbrev company-dabbrev-code company-files))
;; (setq-hook! 'rustic-mode-hook +lsp-company-backends '(company-capf company-yasnippet company-dabbrev company-dabbrev-code company-files))
(setq-hook! 'css-mode +lsp-company-backends '(company-css))
(after! css (set-company-backend! 'css-mode 'company-css 'company-capf 'company-files 'company-dabbrev 'company-yasnippet))

(global-set-key (kbd "M-o") 'dabbrev-completion) ;; this is better as it gives choice
(define-key evil-insert-state-map (kbd "M-N") #'completion-at-point) 
(define-key evil-insert-state-map (kbd "M-n") #'company-capf)
(define-key evil-insert-state-map (kbd "M-/") #'company-dabbrev)


;; (after! lsp 
;;         (setq centaur-tabs-mode nil))
;; (add-hook 'vterm-mode-hook (lambda () (setq evil-default-state 'emacs)))
;; (after! company-mode
;; (define-key company-active-map (kbd "<tab>") #'company-complete))
;; (define-key company-active-map (kbd "Retn") 'nill)

;; trying to fix vterm this currently works fine
(add-hook 'vterm-mode-hook 'evil-emacs-state)
;; (add-to-list 'evil-emacs-state-modes 'vterm-mode) ;; this also works fine but one time it was not

(after! vterm
(define-key vterm-mode-map (kbd "M-k") 'evil-window-up)
(define-key vterm-mode-map (kbd "M-j") 'evil-window-down)
(define-key vterm-mode-map (kbd "M-l") 'evil-window-right)
(define-key vterm-mode-map (kbd "M-h") 'evil-window-left))

(after! treemacs
        (define-key treemacs-mode-map (kbd "M-l") 'evil-window-right)
        (define-key treemacs-mode-map (kbd "M-h") 'evil-window-left))
(setq lsp-treemacs-sync-mode t)
(setq treemacs-project-follow-mode t)
(setq lsp-treemacs-symbols-position-params '((side . right) (slot . 2) (window-width . 35)))


;; (define-key vterm-mode-map (kbd "L") 'next-buffer)
;; (define-key vterm-mode-map (kbd "H") 'previous-buffer))

;; (define-key vterm-mode-map (kbd "C-j") 'evil-window-down)
;; (define-key vterm-mode-map (kbd "M-p") 'vterm-send-M-p)
;; (define-key vterm-mode-map (kbd "M-n") 'vterm-send-M-n)


;; (setq projectile-project-search-path '(("~/Projects" . 1))) ;; this is not working for some reason
(setq projectile-project-search-path '("~/Projects/others/" "~/Projects/"))
;; (setq projectile-project-search-path '("/anand/Projects/" "/anand/Projects/others"))
(setq projectile-auto-discover t)
;; (setq projectile-project-root '~/Projects')

;; (after! projectile 
;;     (setq projectile-project-root-files-bottom-up (remove ".git" projectile-project-root-files-bottom-up)))


(define-key evil-insert-state-map (kbd "M-k") 'evil-window-up)
(define-key evil-insert-state-map (kbd "M-j") 'evil-window-down)
(define-key evil-insert-state-map (kbd "M-l") 'evil-window-right)
(define-key evil-insert-state-map (kbd "M-h") 'evil-window-left)

;; (defun jpk/eshell-mode-hook ()
;;   (company-mode -1))
;; (add-hook 'eshell-mode-hook #'jpk/eshell-mode-hook)

;; (after! eshell
  ;; (setq company-mode nil))

;; these 2 fucntions works perfectly fine
(defun jpk/company-idle-delay-nil-eshell ()
  (when (eq major-mode 'eshell-mode)
    (setq-local company-idle-delay nil)))

(add-hook 'eshell-mode-hook #'jpk/company-idle-delay-nil-eshell )

(defun jpk/company-idle-delay-nil-org ()
  (when (eq major-mode 'org-mode)
    (setq-local company-idle-delay nil)))
(add-hook 'org-mode-hook #'jpk/company-idle-delay-nil-org )

;; (defun jpk/css-company-mode ()
;;   (when (eq major-mode 'css-mode)
;;     (setq company-idle-delay nil)))
;; (add-hook 'org-mode-hook #'jpk/company-idle-delay-nil-org )

;; (autoload 'css-mode "css-mode")
;; (setq auto-mode-alist       
;;      (cons '("\\.css\\'" . css-mode) auto-mode-alist))

;; to increase speed
;;; add to $DOOMDIR/config.el
(advice-add #'add-node-modules-path :override #'ignore)

(advice-add #'+javascript-add-npm-path-h :override #'ignore)



;; (global-set-key (kbd "") #'imenu-list-smart-toggle)

(map! :leader 
      :desc "toggling imenu-list"
      "tt" #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)



;; setting up fzf keybinds
(map! :leader
      (:prefix ("e" . "fzf")
       :desc "fzf_projectile"      "a" #'fzf-projectile
       :desc "fzf_git"             "g" #'fzf-git
       :desc "fzf_find_file"        "f" #'fzf-find-file
       :desc "fzf"                  "e" #'fzf
       :desc "fzf_directory"         "d" #'fzf-directory
       :desc "fzf_grep_in_dir_with_narrwing"      "g" #'fzf-grep-in-dir-with-narrwing
       :desc "fzf_grep_in_dir"         "G" #'fzf-grep-in-dir
       :desc "fzf_find_in_buffer"         "b" #'fzf-find-in-buffer
       :desc "fzf_git_grep"         "B" #'fzf_git_grep))



(defun jpk/web-mode-yas-after-exit-snippet-hook ()   
  (when (eq major-mode 'web-mode)
    (setq-local yas-after-exit-snippet-hook nil)))  ;; disabling it since it was throwing some error only in html files

(add-hook 'web-mode-hook #'jpk/web-mode-yas-after-exit-snippet-hook)



        ;; (setq auto-revert-use-notify t)
        ;; (setq global-auto-revert-mode t)

;; (use-package! autorevert
;;   ;; revert buffers when their files/state have changed
;;   :hook (focus-in . doom-auto-revert-buffers-h)
;;   :hook (after-save . doom-auto-revert-buffers-h)
;;   :hook (doom-switch-buffer . doom-auto-revert-buffer-h)
;;   :hook (doom-switch-window . doom-auto-revert-buffer-h)
;;   :config
;;   (setq auto-revert-verbose t ; let us know when it happens
;;         ;; auto-revert-use-notify nil
;;         auto-revert-use-notify t
;;         auto-revert-stop-on-user-input nil
;;         ;; Only prompts for confirmation when buffer is unsaved.
;;         revert-without-query (list ".")))

(after! autorevert
      (setq auto-revert-use-notify t)
      (setq auto-revert-verbose t))
(global-auto-revert-mode) ;; running it as a function otherwise it does not work


 ;; Run C/c++/python/js programs directly from within emacs
(defun execute-c-program ()
  (interactive)
  (defvar foo)
  ;; (setq foo (concat "gcc " (buffer-file-name)" < "(file-name-directory buffer-file-name)"/in.txt >"(file-name-directory buffer-file-name)"/out.txt && ./a.out" ))
  (setq foo (concat (save-buffer buffer-file-name) "gcc " (buffer-file-name)" &> ./out.txt&& ./a.out < ./in.txt &> ./out.txt" ))
  (shell-command foo))

(add-hook 'c-mode-hook '(lambda () 
                              (local-set-key (kbd "<f9>") 'execute-c-program)))


(defun execute-cpp-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat (save-buffer buffer-file-name) "g++ " (buffer-file-name)" &> ./out.txt && ./a.out < ./in.txt &> ./out.txt" ))
  (shell-command foo))

(add-hook 'c++-mode-hook '(lambda () 
                              (local-set-key (kbd "<f9>") 'execute-cpp-program)))

(defun execute-node-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat (save-buffer buffer-file-name) "node " (buffer-file-name)" &> ./out.txt" ))
  (shell-command foo))

(add-hook 'rjsx-mode-hook '(lambda () 
                              (local-set-key (kbd "<f9>") 'execute-node-program)))


(defun execute-python-program ()
  (interactive)
  (defvar foo)
  (setq foo (concat (save-buffer buffer-file-name) "python " (buffer-file-name)" < ./in.txt &> ./out.txt" ))
  (shell-command foo))

(add-hook 'python-mode-hook '(lambda () 
                              (local-set-key (kbd "<f9>") 'execute-python-program)))
