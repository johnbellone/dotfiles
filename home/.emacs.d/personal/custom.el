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

;; Give me the full screen without any menu or toolbars.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Required packages that I always want loaded up in my environment.
(use-package dired+
  :config
  (progn
    (use-package dired-details)
    (use-package dired-details+)) :ensure)
(use-package diminish :ensure)
(use-package fic-mode :ensure)
(use-package flymake-mode :ensure)
(use-package magit-push-remote :ensure)
(use-package yaml-mode :ensure)
(use-package flycheck-mode :ensure)

;; Packages that should be loaded up on the first initialization.
(use-package csharp-mode)
(use-package crontab-mode)
(use-package bitly)
(use-package emamux)
(use-package magit-gh-pulls)
(use-package google-c-style)
(use-package google-this)
(use-package markdown-mode
  :config
  (progn
    (use-package markdown-mode+)))
(use-package magit
  :config
  (progn
    (use-package magithub)))
(use-package coffee-mode
  :mode ("\\.coffee$" . coffee-mode)
  :config
  (progn
    (use-package flymake-coffee)))
(use-package js3-mode
  :mode ("\\.js$" . js3-mode)
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.json$" . js3-mode))
    (use-package flymake-json)))
(use-package ack
  :config
  (progn
    (use-package ack-menu)))
(use-package enh-ruby-mode
  :mode ("\\.rb$" . enh-ruby-mode)
  :diminish enh-ruby-mode
  :config
  (progn
    ;; Load up the required packages (minor modes).
    (use-package rbenv)
    (use-package rspec-mode)
    (use-package yard-mode)
    (use-package ruby-interpolation-mode)
    (use-package ruby-hash-syntax)
    (use-package ruby-tools)
    (use-package rubocop)
    ;; Use the rbenv shim instead of 1.8 Ruby.
    (defvar rbenv-ruby-shim (rbenv--expand-path "shims" "ruby"))
    (rbenv-use-global)
    (global-rbenv-mode)
    (setq enh-ruby-program (describe-variable 'rbenv-ruby-shim))
    ;; Add files to the global font-lock list for this mode.
    (add-to-list 'auto-mode-alist '("\\Capfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Cheffile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Guardfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Rakefile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Berksfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Godfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Gearfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Procfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Vagrantfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\Gemfile$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.god$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    ;; Setup the hook for the mode (turning on minor modes, etc).
    (add-hook 'enh-ruby-mode-hook
              (lambda ()
                (setq enh-ruby-bounce-deep-indent 1)
                (yard-mode)
                (fic-mode)
                (flymake-mode)
                (ruby-electric-mode)
                (ruby-interpolation-mode)))))
(use-package go-mode
  :mode ("\\.go$" . go-mode)
  :config
  (progn
    (use-package flymake-go)
    (use-package go-autocomplete)
    (use-package go-eldoc)
    (use-package go-play)
    (use-package go-snippets)
    ;; Setup the hook for the mode (turning on minor modes, etc).
    (add-hook 'go-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'gofmt-before-save)))))

(custom-set-variables
 '(temporary-file-directory "/tmp")
 '(flymake-max-parallel-syntax-checks 8)
 '(flymake-run-in-place nil)
 '(legalese-default-author "John Bellone <john.bellone.jr@gmail.com>")
 '(legalese-default-license 'mit))

(provide 'custom)
;;; custom.el ends here
