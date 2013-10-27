;;; package --- Customized settings for my Emacs environment.

;; Copyright (c) 2013 John Bellone <john.bellone.jr@gmail.com>

;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

;;; Commentary:

;; For the longest time I actually maintained my own Emacs settings.  This was
;; was an absolute, pain the ass.  Once I found Prelude I decided that I was no
;; longer going to waste my time doing this.  Rather than that I decided that
;; I would spend my time, like many others, customizing the foundation that has
;; been so graciously provided.

;;; Code:

;; Setup packages that are utilized for display purposes, or at the
;; very least commonly used.  I believe for the most part Prelude will
;; lazy initialize everything.  Where it doesn't do that I'll just load
;; them up myself (see below).
(prelude-ensure-module-deps '(use-package))
(require 'use-package)

;; Required packages that I always want loaded up in my environment.
(use-package dired+
  :defer t
  :config
  (progn
    (use-package dired-details)
    (use-package dired-details+)))
(use-package company
  :config
  (progn
    (use-package company-inf-ruby :defer t)
    (add-hook 'after-init-hook 'global-company-mode)))
(use-package diminish)
(use-package fic-mode
  :config
  (progn
    (add-hook 'c-mode-hook 'turn-on-fic-mode)
    (add-hook 'go-mode-hook 'turn-on-fic-mode)
    (add-hook 'enh-ruby-mode-hook 'turn-on-fic-mode)))
(use-package flymake-mode :defer t)
(use-package flycheck-mode :defer t)
(use-package flyspell-lazy :defer t)
(use-package yaml-mode
  :defer t
  :config
  (progn
    (use-package flymake-yaml)))

;; Packages that should be loaded up on the first initialization.
(use-package csharp-mode :defer t)
(use-package crontab-mode :defer t)
(use-package bitly :defer t)
(use-package emamux :defer t)
(use-package google-c-style :defer t)
(use-package google-this)
(use-package protobuf-mode :defer t)
(use-package markdown-mode
  :defer t
  :config
  (progn
    (use-package markdown-mode+)))

(use-package magit
  :defer t
  :config
  (progn
    (use-package magit-filenotify)
    (use-package magit-find-file)
    (use-package magit-tramp)
    (use-package magit-push-remote)
    (use-package magit-gh-pulls)
    (use-package magithub)))

(use-package coffee-mode
  :defer t
  :mode ("\\.coffee$" . coffee-mode)
  :config
  (progn
    (use-package flymake-coffee)))

(use-package js2-mode
  :defer t
  :mode ("\\.js$" . js3-mode)
  :config
  (progn
    (use-package flymake-gjshint)))

(use-package json-mode
  :defer t
  :mode ("\\.json$" . json-mode)
  :config
  (progn
    (use-package flymake-json)))

(use-package ack
  :defer t
  :config
  (progn
    (use-package ack-menu)))

(use-package ruby-mode
  :defer t
  :mode ("\\.rb$" . ruby-mode)
  :interpreter ("ruby" . ruby-mode)
  :init
  (progn
    ;; Add files to the global font-lock list for this mode.
    (add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Cheffile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Berksfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Godfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Gearfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.god$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gear$" . ruby-mode)))
  :config
  (progn
    ;; Load up the required packages (minor modes).
    (use-package rbenv
      :config
      (progn
        ;; Use the rbenv shim instead of 1.8 Ruby.
        (defvar rbenv-ruby-shim (rbenv--expand-path "shims" "ruby"))
        (setq enh-ruby-program (describe-variable 'rbenv-ruby-shim))
        (rbenv-use-global)
        (global-rbenv-mode)))
    (use-package rspec-mode
      :config
      (add-hook 'dired-mode-hook 'rspec-dired-mode))
    (use-package yard-mode
      :config
      (add-hook 'ruby-mode-hook 'yard-mode))
    (use-package ruby-tools)
    (use-package ruby-block
      :config
      (add-hook 'ruby-mode-hook 'ruby-block-mode))
    (use-package ruby-end
      :disabled t
      :config
      (add-hook 'ruby-mode-hook 'ruby-end))
    (use-package inf-ruby-mode
      :config
      (progn
        (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
        (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)))
    (use-package robe
      :config
      (add-hook 'ruby-mode-hook 'robe-mode))
    (add-hook 'ruby-mode-hook 'flymake-mode)))

(use-package go-mode
  :defer t
  :mode ("\\.go$" . go-mode)
  :config
  (progn
    (use-package go-autocomplete)
    (use-package go-eldoc)
    (use-package go-snippets)

    ;; Setup the hook for the mode (turning on minor modes, etc).
    (add-hook 'go-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'gofmt-before-save)))))

;; There are a few variables that I am going to always want to modify.  These
;; are generally personalized overrides of the defaults.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("c5207e7b8cc960e08818b95c4b9a0c870d91db3eaf5959dd4eba09098b7f232b" default)))
 '(fic-highlighted-words (quote ("BUG" "TODO" "NOTE" "KLUDGE" "HACK" "FIX" "FIXME")))
 '(flymake-max-parallel-syntax-checks nil)
 '(flymake-run-in-place nil)
 '(legalese-default-author "John Bellone <john.bellone.jr@gmail.com>")
 '(legalese-default-license (quote mit))
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(temporary-file-directory "/tmp"))

(provide 'custom)
;;; custom.el ends here
