(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(global-hl-line-mode)

(setq my-light-theme-background-color "#BCA88E")
(defun set-my-light-theme ()
  (set-face-background hl-line-face "#b4aaa9")
  (set-background-color my-light-theme-background-color))

(defun set-my-dark-terminal-theme ()
  (set-face-background hl-line-face "#141414"))

(defun set-my-custom-theme ()
  (if (display-graphic-p)
      ;; GUI mode
      (progn
        (set-my-light-theme))
      ;; Terminal mode
      (set-my-dark-terminal-theme)))

(set-my-custom-theme)
(add-hook 'after-make-frame-functions 'set-my-custom-theme)

(defun correctly-set-my-light-theme-background-color ()
  (interactive)
  (set-background-color my-light-theme-background-color))
;;(correctly-set-my-background-color)

(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "\C-c r r r") 'restart-emacs)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "<XF86Launch6>") 'make-frame-on-monitor) ;;F15 on Macally
(global-set-key (kbd "M-<XF86Launch6>") 'correctly-set-my-background-color) ;;M-F15 on Macally

(setq exec-path (append exec-path '("/Users/arvind.parthasarathy2/go/bin")))
(setq exec-path (append exec-path '("/Users/arvind.parthasarathy2/.nvm/versions/node/v20.12.2/bin")))
(setenv "PATH" (concat (getenv "PATH") ":/Users/arvind.parthasarathy2/go/bin:/Users/arvind.parthasarathy2/.nvm/versions/node/v20.12.2/bin"))

(windmove-default-keybindings)
(setq column-number-mode t)
(setq confirm-kill-emacs 'yes-or-no-p)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default mode-line-format '((window-number-mode
  (:eval
   (window-number-string))) evil-mode-line-tag "%e" mode-line-front-space mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification "   " mode-line-position (vc-mode vc-mode) "  " mode-line-misc-info mode-line-end-spaces))

(defun toggle-line-numbering ()
   (interactive)
   (pcase (buffer-local-value 'display-line-numbers (current-buffer))
     ('visual (customize-set-variable 'display-line-numbers-type t))
     ('t (customize-set-variable 'display-line-numbers-type nil))
     ('() (customize-set-variable 'display-line-numbers-type 'visual))
    )
   (display-line-numbers-mode)
  )
(global-set-key (kbd "C-M-l") 'toggle-line-numbering)

(setq package-archives
      '(("org" . "https://orgmode.org/elpa/")
     ("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/packages/")))
(setq package-selected-packages
   '(vundo undo-tree lsp-ivy helm counsel ivy ivy-rich swiper auto-package-update treemacs-tab-bar dired-single evil-collection all-the-icons-dired all-the-icons-ibuffer forge which-key hide-mode-line dired-git dired-hacks-utils highlight-indentation highlight-parentheses rainbow-delimiters company company-org-block company-web web-mode scss-mode zoom-window tide toml-mode treemacs-all-the-icons treemacs-evil treemacs-icons-dired treemacs-magit typescript-mode window-number yaml-mode svelte-mode rust-mode rustic restart-emacs python-mode prettier org-babel-eval-in-repl ob-go ob-rust ob-typescript mmm-mode magit go-mode lsp-ui json-mode js2-mode dap-mode evil-commentary evil-easymotion evil-goggles evil-indent-plus evil-lion evil-mark-replace evil-matchit evil-mc-extras evil-numbers evil-org evil-snipe evil-surround evil-terminal-cursor-changer evil-textobj-tree-sitter org emacsql-pg emacsql-sqlite3 emmet-mode dotenv-mode csharp-mode csproj-mode csv-mode cargo cargo-mode))
(package-initialize)

(require 'use-package)

(use-package which-key
  :ensure t
  :init (which-key-mode)
  :config
  (setq which-key-idle-delay 1))

(use-package window-number
  :ensure t
  :config
   (window-number-mode 1)
   (global-set-key (kbd "\C-x o") 'window-number-switch))

(add-hook 'completion-list-mode-hook #'hide-mode-line-mode)
(global-set-key (kbd "C-M-m") 'hide-mode-line-mode)

(defun toggle-zoom-window-zoom ()
  (interactive)
  (hide-mode-line-mode "toggle")
  (zoom-window-zoom))
(global-set-key (kbd "M-z") 'toggle-zoom-window-zoom)


(defun undo-tree-split-side-by-side (original-function &rest args)
  "Split undo-tree side-by-side"
  (let ((split-height-threshold nil)
        (split-width-threshold 0))
    (apply original-function args)))

;; DAP Debugging Settings
(defun start-dap-controls ()
  (interactive)
  (dap-ui-controls-mode t)
  (global-set-key (kbd "<f5>") 'dap-continue)
  (global-set-key (kbd "<f6>") 'dap-next)
  (global-set-key (kbd "<f7>") 'dap-step-in)
  (global-set-key (kbd "<f8>") 'dap-step-out)
  (global-set-key (kbd "<f9>") 'dap-breakpoint-toggle)
  (global-set-key (kbd "M-<f9>") 'dap-ui-breakpoints-list)
  (global-set-key (kbd "C-<f9>") 'dap-ui-breakpoint-condition)
  (global-set-key (kbd "<f4>") 'dap-ui-repl)
  (global-set-key (kbd "C-<f4>") 'dap-ui-repl-company)
  (call-interactively 'dap-debug))

;; Enable copy / cut / paste from the Mac system clipboard
(use-package simpleclip
  :ensure t
  :config
   (simpleclip-mode 1))

;; helm-swoop config and key-bindings
;; (global-set-key (kbd "C-x b") 'switch-to-buffer-other-window)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
;; (use-package helm-org-rifle
;;   :after helm)
(use-package helm
  :ensure t
  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x m") 'helm-M-x)
  (global-set-key (kbd "C-x r b") 'helm-bookmarks)
  (global-set-key (kbd "M-i") 'helm-swoop))

(use-package ivy
  :ensure t
  :bind (("C-s" . swiper)
         ("C-r" . swiper-isearch-backward)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package counsel
  :ensure t
  :bind (("C-x b" . counsel-ibuffer)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :config
  ;; Don't start searches with ^
  (setq ivy-initial-inputs-alist nil))

(use-package ivy-rich
  :ensure t
  :after ivy
  :init
  (ivy-rich-mode 1))

(setq evil-want-keybinding nil)
(setq evil-buffer-regexps
      '(("^ \\*load\\*")
        ("^\*terminal\*")
        ("^\*Messages\*")
        ("^\*Warnings\*")
        ("^\*Test function.*\*")
        ("^\*gopls.*\*")
        ("^\*lsp-log\*")
        ("^\*undo-tree\*")
        ("^\*Help\*")
        ("^\*Apropos\*")
        ("^\*Ibuffer\*")
        ("^\*ielm\*")
        ("^\*Buffer List\*")
        ("^\*Packages\*")
        ("^\*Completions\*")))
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (customize-set-variable 'evil-default-state 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-set-initial-state 'eshell-mode 'emacs)
  (evil-set-initial-state 'eshell 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'ibuffer-mode 'emacs))
(use-package evil-commentary
  :ensure t
  :hook (evil-mode . evil-commentary-mode)
  :config
  (evil-commentary-mode))
(use-package evil-easymotion
  :ensure t
  :after evil)
(use-package evil-matchit
  :ensure t
  :after evil
  :config
  (global-evil-matchit-mode 1))
(use-package evil-snipe
  :ensure t
  :after evil
  :config
  (evil-snipe-mode +1))
(use-package evil-indent-plus
  :ensure t
  :after evil)
(use-package evil-lion
  :ensure t
  :hook (evil-mode . evil-lion-mode))
(use-package evil-goggles
  :ensure t
  :hook (evil-mode . evil-goggles-mode))
(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init '(calendar dired calc ediff)))

(use-package eshell-prompt-extras
  :ensure t)
(use-package eshell
  :after eshell-prompt-extras
  :config
   (with-eval-after-load "esh-opt"
     (autoload 'epe-theme-lambda "eshell-prompt-extras")
     (setq eshell-highlight-prompt nil
           eshell-prompt-function 'epe-theme-lambda)))
(use-package eshell-syntax-highlighting
  :hook (eshell-mode . eshell-syntax-highlighting-global-mode)
  :after eshell-mode
  :ensure t ;; Install if not already installed.
  :config
  ;; Enable in all Eshell buffers.
  (eshell-syntax-highlighting-global-mode +1))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
                              "h" 'dired-single-up-directory
                              "l" 'dired-single-buffer)
  (define-key dired-mode-map [remap dired-find-file]
    'dired-single-buffer)
  (define-key dired-mode-map [remap dired-mouse-find-file-other-window]
    'dired-single-buffer-mouse)
  (define-key dired-mode-map [remap dired-up-directory]
    'dired-single-up-directory))
(use-package dired-single
  :after dired)
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package rainbow-delimiters
  :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))
(use-package highlight-parentheses
  :ensure t
  :hook (prog-mode . highlight-parentheses-mode))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  (customize-set-variable 'undo-tree-enable-undo-in-region t)
  (customize-set-variable 'undo-tree-visualizer-diff t)
  (define-key undo-tree-map "\C-xu" nil)
  (advice-add 'undo-tree-visualize :around #'undo-tree-split-side-by-side))

(use-package vundo
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; The first time, run M-x dap-cpptools-setup
(setq-default lsp-enable-dap-auto-configure nil)
(use-package dap-dlv-go
  :after go-mode)
(use-package dap-cpptools
  :after rust-mode)

;; LSP
(use-package lsp-mode
  :ensure t
  :hook
  (prog-mode . lsp-mode)
  (lsp-mode . lsp-enable-which-key-integration)
  :after (:any go-mode rust-mode typescript-mode js-mode scss-mode html-mode java-mode csharp-mode)
  :config
  (add-to-list 'lsp-language-id-configuration '(emacs-lisp-mode . "elisp"))
  (add-to-list 'lsp-language-id-configuration '(go-ts-mode . "go"))
  (define-key lsp-mode-map "\C-cld" 'start-dap-controls)
  (define-key lsp-mode-map "\C-clig" 'lsp-ivy-global-workspace-symbol)
  (define-key lsp-mode-map "\C-cliw" 'lsp-ivy-workspace-symbol)
  (setq lsp-go-analyses '((shadow . t)
                        (simplifycompositelit . :json-false))))
(setq lsp-keymap-prefix "C-c l")
(use-package dap-mode
  :ensure t
  :hook (lsp-mode . dap-mode))
(use-package dap-ui-mode
  :hook (dap-mode . dap-ui-mode))

(use-package lsp-ui
  :after lsp)
(use-package lsp-ivy
  :after lsp)
(use-package dap-gdb-lldb
  :after dap-mode)

(use-package tree-sitter
  :hook (lsp-mode . tree-sitter-mode))
(use-package evil-textobj-tree-sitter
  :after tree-sitter)

(use-package company
  :ensure t
  :after lsp-mode
  :hook
  (prog-mode . company-mode)
  (dap-ui-repl-mode . company-mode)
  :bind
  (:map company-active-map ("<tab>" . company-complete-selection))
  (:map lsp-mode-map ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package forge
  :ensure t
  :after magit)

;; Typescript IDE mode
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1)
  (setq tab-width 2))

(setq mmm-global-mode 'maybe)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     nil
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-project-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-c t 1"   . treemacs-delete-other-windows)
        ("C-c t t"   . treemacs)
        ("C-c t d"   . treemacs-select-directory)
        ("C-c t e"   . treemacs-edit-workspaces)
        ("C-c t c"   . treemacs-create-workspace)
        ("C-c t r"   . treemacs-remove-workspace)
        ("C-c t s"   . treemacs-switch-workspace)
        ("C-c t B"   . treemacs-bookmark)
        ("C-c t f"   . treemacs-find-file)
        ("C-c t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-maybe))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eshell-visual-options '(("git" "--help" "--paginate")))
 '(eshell-visual-subcommands '(("git" "log" "diff" "show" "branch")))
 '(global-undo-tree-mode t)
 '(highlight-parentheses-colors '("#59981a" "#3d550c" "#18a558" "#116530"))
 '(package-selected-packages
   '(simpleclip yasnippet lsp-mode tree-sitter tree-sitter-indent tree-sitter-ispell toml vundo undo-tree lsp-ivy helm counsel ivy ivy-rich swiper auto-package-update treemacs-tab-bar dired-single evil-collection all-the-icons-dired all-the-icons-ibuffer which-key hide-mode-line dired-git dired-hacks-utils highlight-indentation highlight-parentheses rainbow-delimiters company company-org-block company-web web-mode scss-mode zoom-window tide toml-mode treemacs-all-the-icons treemacs-evil treemacs-icons-dired treemacs-magit typescript-mode window-number yaml-mode svelte-mode rust-mode rustic restart-emacs python-mode prettier org-babel-eval-in-repl ob-go ob-rust ob-typescript mmm-mode magit go-mode lsp-ui json-mode js2-mode evil-commentary evil-easymotion evil-goggles evil-indent-plus evil-lion evil-mark-replace evil-matchit evil-mc-extras evil-numbers evil-org evil-snipe evil-surround evil-terminal-cursor-changer evil-textobj-tree-sitter org emacsql-pg emacsql-sqlite3 emmet-mode dotenv-mode csharp-mode csproj-mode csv-mode cargo cargo-mode))
 '(undo-tree-enable-undo-in-region t)
 '(undo-tree-history-directory-alist
   '((".*" . "/Users/arvind.parthasarathy2/.emacs.d/undo-tree")))
 '(undo-tree-visualizer-diff t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dap-ui-controls-fringe ((t (:background "#67595e"))))
 '(dap-ui-marker-face ((t (:background "#f7edd0"))))
 '(dap-ui-pending-breakpoint-face ((t (:background "#efcfa0"))))
 '(dap-ui-verified-breakpoint-face ((t (:background "#eed6d3"))))
 '(epe-git-face ((t (:foreground "#228b22"))))
 '(error ((t (:foreground "#e43d40" :slant oblique :weight bold))))
 '(font-lock-constant-face ((t (:foreground "#0074b7"))))
 '(font-lock-function-name-face ((t (:foreground "#627799" :weight semi-bold))))
 '(font-lock-keyword-face ((t (:foreground "#6f5296" :weight semi-bold))))
 '(font-lock-type-face ((t (:foreground "#116530"))))
 '(font-lock-variable-name-face ((t (:foreground "#a0522d" :weight semi-bold))))
 '(fringe ((t (:background "#a49393"))))
 '(header-line ((t (:inherit mode-line :background "#b89e90" :foreground "#532200" :box nil))))
 '(helm-M-x-key ((t (:extend t :foreground "#464033" :box (1 . -1)))))
 '(helm-ff-invalid-symlink ((t (:extend t :background "#e4d4c8" :foreground "red"))))
 '(helm-ff-suid ((t (:extend t :background "#945055" :foreground "#eaeaea"))))
 '(helm-lisp-completion-info ((t (:extend t :foreground "#945055"))))
 '(helm-match ((t (:extend t :foreground "#b95c50"))))
 '(helm-prefarg ((t (:extend t :foreground "#945055"))))
 '(helm-resume-need-update ((t (:extend t :background "#945055"))))
 '(helm-selection ((t (:extend t :background "#bc9476" :distant-foreground "black"))))
 '(helm-separator ((t (:extend t :foreground "#b95c50"))))
 '(helm-source-header ((t (:extend t :background "#464033" :foreground "#bbc4c2" :weight bold :height 1.1 :family "Sans Serif"))))
 '(helm-time-zone-current ((t (:extend t :foreground "#67595e"))))
 '(helm-time-zone-home ((t (:extend t :foreground "#464033"))))
 '(helm-visible-mark ((t (:extend t :background "#7e7c73"))))
 '(highlight ((t (:background "#bc8f8f"))))
 '(ivy-current-match ((t (:extend t :background "#dfd6d1" :foreground "#1f232c"))))
 '(ivy-minibuffer-match-face-1 ((t (:background "#d1d0d0"))))
 '(ivy-minibuffer-match-face-2 ((t (:background "#988686" :weight bold))))
 '(ivy-minibuffer-match-face-3 ((t (:background "#ccafa5" :weight bold))))
 '(ivy-minibuffer-match-face-4 ((t (:background "#dcd2cc" :weight bold))))
 '(line-number ((t (:background "#bc9476" :foreground "#e4d4c8"))))
 '(lsp-headerline-breadcrumb-path-face ((t (:foreground "#006400"))))
 '(lsp-headerline-breadcrumb-symbols-face ((t (:foreground "#551a8b" :weight bold))))
 '(magit-diff-base-highlight ((t (:extend t :background "#eeeebb" :foreground "#055c9d"))))
 '(magit-diff-context ((t (:extend t :foreground "#5b89ae"))))
 '(magit-hash ((t (:foreground "#055c9d"))))
 '(magit-section-highlight ((t (:extend t :background "#b4aaa9"))))
 '(mode-line ((t (:background "#d0b49f" :foreground "#523a28" :box (:line-width (1 . -1) :style released-button)))))
 '(mode-line-highlight ((t (:box (:line-width (2 . 2) :color "#2e8bc0" :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#e4d4c8" :foreground "#868b8e" :box (:line-width (1 . -1) :color "#dbe8d8") :weight light))))
 '(rainbow-delimiters-base-error-face ((t (:inherit rainbow-delimiters-base-face :background "#c26dbc" :foreground "#970c10" :weight ultra-bold :height 1.2))))
 '(rainbow-delimiters-base-face ((t (:inherit nil :weight bold :height 1.0))))
 '(rainbow-delimiters-depth-1-face ((t (:inherit rainbow-delimiters-base-face :foreground "#5e376d"))))
 '(rainbow-delimiters-depth-2-face ((t (:inherit rainbow-delimiters-base-face :foreground "#106091"))))
 '(rainbow-delimiters-depth-3-face ((t (:inherit rainbow-delimiters-base-face :foreground "#777fff"))))
 '(rainbow-delimiters-depth-4-face ((t (:inherit rainbow-delimiters-base-face :foreground "#a06ab4"))))
 '(rainbow-delimiters-depth-5-face ((t (:inherit rainbow-delimiters-base-face :foreground "#532200"))))
 '(rainbow-delimiters-depth-6-face ((t (:inherit rainbow-delimiters-base-face :foreground "#41729f"))))
 '(rainbow-delimiters-depth-7-face ((t (:inherit rainbow-delimiters-base-face :foreground "#A76286"))))
 '(rainbow-delimiters-depth-8-face ((t (:inherit rainbow-delimiters-base-face :foreground "#a47551"))))
 '(rainbow-delimiters-depth-9-face ((t (:inherit rainbow-delimiters-base-face :foreground "#5885af"))))
 '(rainbow-delimiters-mismatched-face ((t (:background "#f9bdc0" :foreground "#f51720" :weight ultra-bold :height 1.2))))
 '(warning ((t (:foreground "#e55b13" :slant oblique :weight bold))))
 '(widget-field ((t (:extend t :background "#efcfa0"))))
 '(window-number-face ((t (:background "#e7d2cc" :foreground "#0074b7"))) t))
