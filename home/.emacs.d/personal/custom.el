;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "John Bellone"
      user-mail-address "john.bellone.jr@gmail.com")

(setq load-prefer-newer t
      gc-cons-threshold 50000000
      large-file-warning-threshold 100000000)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(setq whitespace-line-column 120
      scroll-margin 0
      scroll-step 1
      scroll-conservatively 100000
      scroll-preserve-screen-position 1
      prelude-whitespace nil)

(prelude-require-packages '(use-package))
(require 'use-package)

(define-key emacs-lisp-mode-map (kbd "<S-iso-lefttab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<backtab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<S-tab>")  'lisp-complete-symbol)

(use-package org
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  :diminish visual-line-mode
  :diminish org-indent-mode
  :defer t
  :bind (("\C-c a" . org-agenda)
         ("\C-c c" . org-capture))
  :config
  (setq org-directory "~/org"
        org-default-notes-file "~/org/refile.org"
        org-agenda-files (quote "~/org"))
  (defvar org-default-diary-file "~/org/diary.org")
  (setq org-startup-indented t
        org-startup-folded "showall"
        org-cycle-separator-lines 0
        org-tags-column 80
        org-agenda-tags-column org-tags-column
        org-agenda-sticky t
        org-src-fontify-natively t
        org-use-speed-commands t)
  (setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %16TIMESTAMP_IA")
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "red" :weight bold)
          ("NEXT" :foreground "blue" :weight bold)
          ("DONE" :foreground "forest green" :weight bold)
          ("WAITING" :foreground "orange" :weight bold)
          ("INACTIVE" :foreground "magenta" :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold)
          ("MEETING" :foreground "forest green" :weight bold)))
  (setq org-todo-state-tags-triggers
        '(("CANCELLED" ("CANCELLED" . t))
          ("WAITING" ("WAITING" . t))
          ("INACTIVE" ("WAITING") ("INACTIVE" . t))
          (done ("WAITING") ("INACTIVE"))
          ("TODO" ("WAITING") ("CANCELLED") ("INACTIVE"))
          ("NEXT" ("WAITING") ("CANCELLED") ("INACTIVE"))
          ("DONE" ("WAITING") ("CANCELLED") ("INACTIVE")))))
                                      
(use-package gitattributes-mode :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package google-c-style
  :config
  (progn
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent)))
(use-package ssh-config-mode :ensure t)

(when (eq system-type "darwin")
  (set-face-attribute 'default nil :family "Inconsolata-dz")
  (set-face-attribute 'default nil :height 140)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)
  (ns-set-resource nil "ApplePressAndHoldEnabled" "NO")
  (use-package osx-browse :ensure t)
  (use-package osx-clipboard :ensure t)
  (use-package osx-lib :ensure t)
  (use-package osx-pseudo-daemon :ensure t))

(use-package company)
(use-package company-inf-ruby
  :after company
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package json-mode)
(use-package flymake-json :after json-mode)

(use-package helm)
(use-package ac-helm
  :after helm
  :config (add-to-list 'ac-modes 'helm-mode))

(use-package coffee-mode)
(use-package flymake-coffee :after coffee-mode)

(use-package yaml-mode)
(use-package flymake-yaml :after yaml-mode)

(use-package go-mode)
(use-package go-autocomplete
  :after go-mode
  :config (add-to-list 'ac-modes 'go-mode))
(use-package go-eldoc :after go-mode)

(use-package salt-mode)

(use-package jinja2-mode
  :mode ("\\.jinja$" . jinja2-mode))

(use-package enh-ruby-mode
  :ensure t
  :mode ("\\.rb$" . enh-ruby-mode)
  :interpreter ("ruby" . enh-ruby-mode)
  :config
  (progn
    (require 'smartparens-ruby)
    (add-hook 'enh-ruby-mode-hook 'smartparens-mode)

    (setq-default enh-ruby-extra-keywords (list "public" "private" "protected" "include" "extend"))
    (erm-reset)
    (setq enh-ruby-bounce-deep-indent t)
    (setq enh-ruby-hanging-brace-indent-level 2)
    (setq enh-ruby-check-syntax nil)

    (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Capfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Berksfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Guardfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Thorfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Vagrantfile$" . enh-ruby-mode))))
(use-package ruby-electric
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode))
(use-package yard-mode
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'yard-mode))
(use-package robe
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'robe-mode))
(use-package ruby-block
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'ruby-block-mode))
(use-package inf-ruby
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))

;; http://www.emacswiki.org/emacs/EmacsClient#WMFocus
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

;;; custom.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (orca org-agenda-property org-doing org-ref osx-clipboard osx-lib osx-plist osx-trash org-projectile-helm docker docker-api docker-compose-mode docker-tramp dockerfile-mode groovy-mode flycheck-plantuml plantuml-mode protobuf-mode markdown-mode ac-c-headers ac-cider ac-etags ac-html ac-inf-ruby ace-flyspell cider-decompile cider-eval-sexp-fu cider-hydra cider-profile cider-spy clj-refactor cljr-helm clojure-mode-extra-font-locking flycheck-clojure inf-clojure org-ac org-autolist org-journal org-projectile company-inf-ruby zop-to-char zenburn-theme yari yard-mode which-key web-mode volatile-highlights vkill use-package undo-tree ssh-config-mode smex smartrep smartparens smart-mode-line slime salt-mode ruby-tools ruby-electric ruby-block robe rainbow-mode rainbow-delimiters racer ov operate-on-number move-text magit key-chord json-mode js2-mode jinja2-mode imenu-anywhere ido-completing-read+ helm-projectile helm-descbinds helm-ag guru-mode grizzl gotest google-c-style god-mode go-projectile go-autocomplete gitignore-mode gitconfig-mode gitattributes-mode git-timemachine gist geiser flymake-yaml flymake-json flymake-coffee flycheck-rust flx-ido expand-region exec-path-from-shell enh-ruby-mode elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux counsel company-go company-auctex company-anaconda coffee-mode cider chruby cdlatex cargo browse-kill-ring beacon anzu ace-window ac-helm)))
 '(plantuml-jar-path "/usr/local/Cellar/plantuml/1.2018.1/libexec/plantuml.jar"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
