;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:
(set-frame-font "Consolas-14")
(setq whitespace-line-column 120)
(tool-bar-mode -1)
(menu-bar-mode -1)

(prelude-require-packages '(use-package))
(require 'use-package)

(use-package gitattributes-mode :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package google-c-style :ensure t)
(use-package ssh-config-mode :ensure t)

(use-package osx-browse :ensure t)
(use-package osx-clipboard :ensure t)
(use-package osx-lib :ensure t)
(use-package osx-pseudo-daemon :ensure t)

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
  (chruby "2.2"))

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
    (use-package go-eldoc :ensure t)
    (add-hook 'go-mode-hook
              (progn
                (add-hook 'before-save-hook 'gofmt-before-save)))))

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
  (context 2))

(provide 'custom)
;;; custom.el ends here
