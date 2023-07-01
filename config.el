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
;; (setq doom-theme 'doom-homage-black)
;; (setq doom-theme 'doom-moonlight)
(setq doom-theme 'moonlightc)

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

;;dont need it much
;; (global-set-key (kbd "M-H") '+evil/window-move-left)
;; (global-set-key (kbd "M-L") '+evil/window-move-right)
;; (global-set-key (kbd "M-K") '+evil/window-move-up)
;; (global-set-key (kbd "M-J") '+evil/window-move-down)
(tab-bar-mode)
(setq tab-bar-show 1)
(define-key evil-normal-state-map (kbd "M-H") 'tab-bar-switch-to-next-tab)
(define-key evil-normal-state-map (kbd "M-L") 'tab-bar-switch-to-prev-tab)
(define-key evil-insert-state-map (kbd "M-H") 'tab-bar-switch-to-next-tab)
(define-key evil-insert-state-map (kbd "M-L") 'tab-bar-switch-to-prev-tab)

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


;; never ask for closing emacs
(setq confirm-kill-emacs nil)

;; to avoid the which key being covered by status line
(setq which-key-allow-imprecise-window-fit nil)



;; if want to disable auto-completion
;; (after! company
;;   (setq company-idle-delay nil))

;; company settings
(setq company-idle-delay 0.1
      ;; company-tooltip-idle-delay 0
      company-tooltip-maximum-width 100
      company-minimum-prefix-length 1
      company-box-doc-delay 0.1
      ;; company-require-match nil
      ;; company-tooltip-align-annotations t
       ;; company-tooltip-flip-when-above t
      company-show-numbers t
      company-frontends
      '(company-pseudo-tooltip-frontend
        company-preview-frontend
        company-echo-metadata-frontend))

;; (company-quickhelp-mode)
;; (setq company-quickhelp-delay 0.1)

;; (use-package lsp-ui)
;;   (setq lsp-ui-doc-enable t)
;;   ;; (setq lsp-ui-doc-show-with-cursor t)
;;   (setq lsp-ui-doc-show-with-mouse t)

(after! lsp-ui
        (setq lsp-ui-doc-enable t)
        (setq lsp-ui-doc-show-with-mouse t)
       (setq lsp-ui-doc-max-height 100)
        (setq lsp-ui-doc-max-width 200)
        (setq lsp-ui-sideline-enable t)
        (setq lsp-ui-sideline-show-code-actions t))

(setq lsp-modeline-code-actions-mode t)
(setq lsp-completion-show-detail nil)



;; (defun my/company-show-doc-buffer ()
;;   "Temporarily show the documentation buffer for the selection."
;;   (interactive)
;;   (let* ((selected (nth company-selection company-candidates))
;;          (doc-buffer (or (company-call-backend 'doc-buffer selected)
;;                          (error "No documentation available"))))
;;     (with-current-buffer doc-buffer
;;       (goto-char (point-min)))
;;     (select-window (display-buffer doc-buffer t))))

;; (defun my/company-show-doc-buffer ()
;;   "Temporarily show the documentation buffer for the selection."
;;   (interactive)
;;   (let* ((selected (nth company-selection company-candidates))
;;          (doc-buffer (or (company-call-backend 'doc-buffer selected)
;;                          (error "No documentation available"))))
;;     (with-current-buffer doc-buffer
;;       (goto-char (point-min)))
;;        ;; (local-set-key (kbd "q") 'kill-buffer-and-window)
;;        ;; (not-modified)
;;        ;; (read-only-mode))
;;      (pop-to-buffer doc-buffer '((display-buffer-below-selected)
;;                                (window-parameters . ((no-other-window . nil)))
;;                                (window-height . fit-window-to-buffer)))))


;; currently this works perfectly fine but cannot change its mode 
(defun my/company-show-doc-buffer ()
  "Temporarily show the documentation buffer for the selection."
  (interactive)
  (let* ((myselected (nth company-selection company-candidates))
         (my-doc-buffer (or (company-call-backend 'doc-buffer myselected)
                         (error "No documentation available"))))
    (with-current-buffer my-doc-buffer
      (goto-char (point-min)))
     (pop-to-buffer my-doc-buffer '((display-buffer-below-selected)
                               (window-parameters . ((no-other-window . nil)))
                               (window-height . 200)))))

;; it will open the doc buffer permenantly and we have to close it manually
(define-key evil-insert-state-map (kbd "C-o") #'my/company-show-doc-buffer)


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


;; (add-hook 'vterm-mode-hook (lambda () (setq evil-default-state 'emacs)))

;; trying to fix vterm this currently works fine
(add-hook 'vterm-mode-hook 'evil-emacs-state)
;; (add-to-list 'evil-emacs-state-modes 'vterm-mode) ;; this also works fine but one time it was not

(after! vterm
(define-key vterm-mode-map (kbd "M-k") 'evil-window-up)
(define-key vterm-mode-map (kbd "M-j") 'evil-window-down)
(define-key vterm-mode-map (kbd "M-H") 'previous-buffer)
(define-key vterm-mode-map (kbd "M-L") 'next-buffer)
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


;; to increase speed
;;; add to $DOOMDIR/config.el
(advice-add #'add-node-modules-path :override #'ignore)

(advice-add #'+javascript-add-npm-path-h :override #'ignore)


(map! :leader 
      :desc "toggling imenu-list"
      "tt" #'imenu-list-smart-toggle)
(setq imenu-list-focus-after-activation t)



;;setting up fzf keybinds
(map! :leader
      (:prefix ("e" . "fzf")
       :desc "fzf_projectile"      "a" #'fzf-projectile
       :desc "fzf_git"             "g" #'fzf-git
       :desc "fzf_find_file"        "f" #'fzf-find-file
       :desc "fzf"                  "e" #'fzf
       :desc "fzf_directory"         "d" #'fzf-directory
       :desc "fzf_grep_in_dir_with_narrwing"   "D" #'fzf-grep-in-dir-with-narrwing
       :desc "fzf_grep_in_dir"         "G" #'fzf-grep-in-dir
       :desc "fzf_find_in_buffer"         "b" #'fzf-find-in-buffer
       :desc "fzf_git_grep"         "B" #'fzf_git_grep))



(defun jpk/web-mode-yas-after-exit-snippet-hook ()   
  (when (eq major-mode 'web-mode)
    (setq-local yas-after-exit-snippet-hook nil)))  ;; disabling it since it was throwing some error only in html files

(add-hook 'web-mode-hook #'jpk/web-mode-yas-after-exit-snippet-hook)



        ;; (setq auto-revert-use-notify t)
        ;; (setq global-auto-revert-mode t)

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



;; (setq fzf/directory-start "/home/swaroop/")

;; consult stuff
(defun consult-find-dir-from-home ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find /home/swaroop/ -type d")
  (consult-find))

(defun consult-find-everything-from-home ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find /home/swaroop/")
  (consult-find))


(defun consult-find-everything-form-curdir ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find .")
  (consult-find))

(defun consult-find-dir-in-cur ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find . -type d")
  (consult-find))

(defun consult-find-everything-normal-curdir ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find . -not ( -wholename */.* -prune )")
  (consult-find))

(defun consult-find-directory-normal-curdir ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find . -not ( -wholename */.* -prune ) -type d")
  (consult-find))

(defun consult-find-everything-normal-home ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find /home/swaroop/ -not ( -wholename */.* -prune )")
  (consult-find))

(defun consult-find-directory-normal-home ()
  "Search for regexp with find only DIR in DIR with INITIAL input."
  (interactive)
  (setq consult-find-args "find /home/swaroop/ -not ( -wholename */.* -prune ) -type d")
  (consult-find))

(setq consult-ripgrep-args "rg --null --line-buffered --color=never --max-columns=1000 --path-separator /   --smart-case --no-heading --with-filename --line-number --search-zip --hidden")
;; consult keybinds
(map! :leader
      (:prefix ("k" . "consult")

       :desc "consult_grep"        "g" #'consult-grep
       :desc "consult_ripgrep"        "r" #'consult-ripgrep
       :desc "consult_find_every_~"        "f" #'consult-find-everything-from-home
       :desc "consult_find_every_."          "e" #'consult-find-everything-form-curdir
       :desc "consult_dir_~"         "d" #'consult-find-dir-from-home
       :desc "consult_dir_."         "D" #'consult-find-dir-in-cur
       :desc "consult_line"         "l" #'consult-line
       :desc "consult_line_multi"         "L" #'consult-line-multi
       :desc "consult_project_buffer"         "b" #'consult-project-buffer
       :desc "consult_normal_every_."         "k" #'consult-find-everything-normal-curdir
       :desc "consult_normal_dir_."         "K" #'consult-find-directory-normal-curdir
       :desc "consult_normal_every_~"        "j" #'consult-find-everything-normal-home
       :desc "consult_normal_dir_~"          "J" #'consult-find-directory-normal-home))




(after! eshell
  ;; FIXME: Path-completion, for example with "ls", is disabled until
  ;; `eshell-cmpl-initialize' is called.
  (add-hook! eshell-mode :append #'eshell-cmpl-initialize)
  ;; For some reason, the first `add-hook!' adds
  ;; `eshell-cmpl-initialize' to the beginning, even with `:append'.
  ;; Remove it and add it again to truly append it.
  ;; (When it is at the beginning, it fails to enable completions.)
  (remove-hook! eshell-mode #'eshell-cmpl-initialize)
  (add-hook! eshell-mode :append #'eshell-cmpl-initialize)

  ;; Make sure the hooks were run.
  (add-hook! eshell-mode :append
    (defun my-post-eshell-mode-hook-h ()
      (message "Ran hooks in `eshell-mode-hook'."))))
  

(setq desktop+-base-dir "/home/swaroop/.config/doom/desktops/")


(map! :leader 
      :desc "create-new-desktop" "qj" #'desktop+-create
      :desc "load-desktop" "qk" #'desktop+-load
      :desc "create new tab" "qn" #'tab-bar-new-tab
      :desc "close new tab" "qc" #'tab-bar-close-tab
      :desc "switch to tab" "qm" #'tab-bar-switch-to-tab)



(set-popup-rules!
 '(("^ \\*" :slot -1) ; fallback rule for special buffers
   ("^ \\*" :slot -1) 
   ("^\\*" :height 0.32)
   ;; ("^\\*elgot" :height 0.52)
   ;; ("^\\*company" :height 0.52)
   ("^\\*Completions" :slot -1 :ttl 0)
   ("^\\*\\(?:scratch\\|Messages\\)" :ttl t)
   ("^\\*Help" :slot -1 :size 0.2 :select t)
   ("^\\*doom:"
    :size 0.35 :select t :modeline t :quit t :ttl t)))



;; frog mode
(define-key evil-normal-state-map (kbd "C-a") 'frog-jump-buffer)
(define-key evil-insert-state-map (kbd "C-a") 'frog-jump-buffer)

;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (define-key eshell-mode-map (kbd "C-a") #'frog-jump-buffer)))

(setq frog-jump-buffer-include-current-buffer nil)
(after! frog-jump-buffer
(dolist (regexp '("TAGS" "^\\*Compile-log" "-debug\\*$" "^\\:" "errors\\*$" "^\\*Backtrace" "-ls\\*$" "^\\*doom*" "^\\*scratch" "^\\*Messages" "^\\*Async-native-compile-log" "^\\*lsp-documentaion"
                  "stderr\\*$" "^\\*Flymake" "^\\*vc" "^\\*Warnings" "^\\*eldoc" "^\\*lsp-log" "^\\*clangd" "^\\*Native-compile-log" "^\\async-native-compile-log" "^\\*helpful"))
    (push regexp frog-jump-buffer-ignore-buffers)))

(setq frog-jump-buffer-default-filter 'frog-jump-buffer-filter-same-project)

(defface frog-menu-posframe-background-face
  '((t (:inherit default)))
  "Face used for the background color of the posframe.")


(defface frog-menu-action-keybinding-face
  '((t (:foreground "#ffffff")))
  "Face used for menu action keybindings.")

(defcustom frog-menu-posframe-border-width 3
  "Border width to use for the posframe `frog-menu' creates."
  :type 'integer)

(defun frog-jump-buffer-filter-special-buffers (buffer)
  (with-current-buffer buffer
    (-any? #'derived-mode-p '(eshell-mode))))

(setq frog-jump-buffer-filter-actions
 '(("e" "[special]" frog-jump-buffer-filter-special-buffers)))
;; (setq frog-jump-buffer-sort '(lambda (one two) t)) ;; don't know what it does



(defun my-vertico-select (index)
  (interactive)
  (vertico-next (if (string= vertico-preselect 'prompt) (+ index 1) index)) ;; If `vertico-preselect' is `first' or `prompt', it's mostly working but when `directory' the default value, is described as "Like first, but select the prompt if it is a directory", so the condition switch (the first list item is directory or not) is needed.
  (vertico-exit))

(after! vertico
(vertico-indexed-mode)
(setq vertico-indexed-start 1))
;;keybindings are one shifted because index starts from 0
(define-key minibuffer-local-map (kbd "M-1") (lambda () (interactive) (my-vertico-select 0)))
(define-key minibuffer-local-map (kbd "M-2") (lambda () (interactive) (my-vertico-select 1)))
(define-key minibuffer-local-map (kbd "M-3") (lambda () (interactive) (my-vertico-select 2)))
(define-key minibuffer-local-map (kbd "M-4") (lambda () (interactive) (my-vertico-select 3)))
(define-key minibuffer-local-map (kbd "M-5") (lambda () (interactive) (my-vertico-select 4)))
(define-key minibuffer-local-map (kbd "M-6") (lambda () (interactive) (my-vertico-select 5)))
(define-key minibuffer-local-map (kbd "M-7") (lambda () (interactive) (my-vertico-select 6)))
(define-key minibuffer-local-map (kbd "M-8") (lambda () (interactive) (my-vertico-select 7)))
(define-key minibuffer-local-map (kbd "M-9") (lambda () (interactive) (my-vertico-select 8)))
(define-key minibuffer-local-map (kbd "M-0") (lambda () (interactive) (my-vertico-select 9)))


(global-set-key (kbd "M-,") #'+vertico/switch-workspace-buffer)

;;Tab bar integration
(with-eval-after-load 'tab-bar
  ;; Save the current workspace's tab bar data.
  (add-hook 'persp-before-deactivate-functions
            (lambda (_)
              (set-persp-parameter 'tab-bar-tabs (tab-bar-tabs))
              (set-persp-parameter 'tab-bar-closed-tabs tab-bar-closed-tabs)))
  ;; Restores the tab bar data of the workspace we have just switched to.
  (add-hook 'persp-activated-functions
            (lambda (_)
              (tab-bar-tabs-set (persp-parameter 'tab-bar-tabs))
              (setq tab-bar-closed-tabs (persp-parameter 'tab-bar-closed-tabs))
              (tab-bar--update-tab-bar-lines t)))

)

 ;; Filter frame parameters
  (setq +persp-filter-parameters-on-save
        '((tab-bar-tabs . (lambda (conf) (frameset-filter-tabs conf nil nil t)))
          (winner-ring . ignore)))

(add-hook 'persp-before-save-state-to-file-functions
              (defun +workspaces-save-tab-bar-data-to-file-h (&rest _)
                (when (get-current-persp)
                  (set-persp-parameter 'tab-bar-tabs (frameset-filter-tabs (tab-bar-tabs) nil nil t)))))

(custom-set-faces!
  ;; '(default :background "#000000")
  ;; `(bg :background "#000000")
  ;; `(bg-alt :background "#000000")
  ;; `(tab-bar :background ,(doom-color 'bg-alt))
  ;; `(tab-bar :background "#000000")
  `(cursor :background "#F92660")
  `(frog-menu-posframe-background-face :background "#000000")
  `(tab-bar-tab :foreground "#FFFFFF")
  `(tab-bar-tab-inactive :foreground "#a6adc8")
  `(font-lock-preprocessor-face :foreground "#f7768e"))
   
;; On doom emacs

;; You can use this hydra menu that have all the commands
(map! :n "C-SPC" 'harpoon-quick-menu-hydra)
;; (map! :n "C-s" 'harpoon-add-file) ;; no need for this now

