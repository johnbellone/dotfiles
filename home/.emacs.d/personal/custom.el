;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(setq user-full-name "John Bellone"
      user-mail-address "john.bellone.jr@gmail.com")

(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

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
  :ensure t
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda))
  :config
  (progn
    (setq org-startup-indented t
          org-startup-folded "showall"
          org-directory "~/org"
          org-src-fontify-natively t
          org-use-speed-commands t)))

(use-package gitattributes-mode :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package google-c-style
  :ensure t
  :config
  (progn
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent)))
(use-package ssh-config-mode :ensure t)

(when (eq system-type "darwin")
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)
  (ns-set-resource nil "ApplePressAndHoldEnabled" "NO")
  (use-package osx-browse :ensure t)
  (use-package osx-clipboard :ensure t)
  (use-package osx-lib :ensure t)
  (use-package osx-pseudo-daemon :ensure t))

(use-package org
  :ensure t
  :config
  (progn
    (use-package org-ac)
    (use-package org-autolist)
    (use-package org-journal)
    (use-package org-projectile)
    (use-package orgit)
    (use-package ox-pandoc)
    (use-package ox-reveal)

    (use-package org2jekyll
      :config
      (progn
        (setq org2jekyll-blog-author "jbellone")
        (setq org2jekyll-jekyll-posts-dir "_posts/")
        (setq org2jekyll-source-directory (expand-file-name "~/Projects/thoughtlessbanter.com"))))))

(use-package chruby
  :ensure t
  :config
  (chruby "2.3"))

(use-package company
  :ensure t
  :config
  (progn
    (use-package company-inf-ruby)
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package json-mode
  :ensure t
  :config
  (use-package flymake-json :ensure t))

(use-package cider
  :ensure t
  :config
  (progn
    (use-package ac-cider)
    (use-package cider-decompile)
    (use-package cider-eval-sexp-fu)
    (use-package cider-profile)
    (use-package cider-spy)
    (use-package clojure-mode-extra-font-locking)
    (use-package clj-refactor)
    (use-package cljr-helm)
    (use-package flycheck-clojure)
    (use-package inf-clojure)))

(use-package helm
  :ensure t
  :config
  (progn
    (use-package ac-helm
      :ensure t
      :config
      (add-to-list 'ac-modes 'helm-mode))))

(use-package coffee-mode
  :ensure t
  :config
  (use-package flymake-coffee :ensure t))

(use-package yaml-mode
  :ensure t
  :config
  (use-package flymake-yaml :ensure t))

(use-package go-mode
  :ensure t
  :config
  (progn
    (use-package go-autocomplete
      :ensure t
      :config
      (add-to-list 'ac-modes 'go-mode))
    (use-package go-eldoc :ensure t)))

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
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode))
(use-package yard-mode
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'yard-mode))
(use-package robe
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'robe-mode))
(use-package ruby-block
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'ruby-block-mode))
(use-package inf-ruby
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))

;; http://www.emacswiki.org/emacs/EmacsClient#WMFocus
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(define-clojure-indent
  (defroutes 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2)
  (defroutes* 'defun)
  (GET* 2)
  (POST* 2)
  (PUT* 2)
  (DELETE* 2)
  (HEAD* 2)
  (ANY* 2)
  (context* 2))

(provide 'custom)
;;; custom.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (enh-ruby-mode markdown-mode ssh-config-mode google-c-style gitattributes-mode use-package yaml-mode web-mode scss-mode geiser ensime scala-mode yari inf-ruby ruby-tools company-anaconda anaconda-mode flycheck-ocaml merlin utop tuareg company-auctex cdlatex auctex json-mode js2-mode haskell-mode gotest go-projectile go-eldoc company-go go-mode alchemist elixir-mode erlang rainbow-mode elisp-slime-nav slime coffee-mode cider clojure-mode rainbow-delimiters key-chord company helm-ag helm-descbinds helm-projectile helm smex ido-completing-read+ flx-ido vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl editorconfig easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
