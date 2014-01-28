;;; custom --- Customized settings for my Emacs environment.
;;
;; Copyright © 2011-2014 John Bellone <john.bellone.jr@gmail.com>
;;
;;; License:
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;;
;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;;
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
(if (x-list-fonts "Inconsolata-18")
    (progn (set-frame-font "Inconsolata-18") t) nil)

(prelude-require-packages '(package+ use-package))

;; Keep some core packages always up-to-date.
(require 'package+)
(package-manifest 'fic-mode
                  'dired+
                  'dired-details
                  'dired-details+
                  'magit
                  'magit-tramp
                  'magit-push-remote)

(global-fic-mode t)

(require use-package)

(use-package chruby
  :config (progn (chruby "2.0.0-p353")))
(use-package company
  :config
  (progn
    (use-package company-inf-ruby :defer t)
    (add-hook 'after-init-hook 'global-company-mode)))
(use-package diminish)
(use-package flymake-mode :defer t)
(use-package flycheck-mode :defer t)
(use-package flyspell-lazy :defer t)
(use-package yaml-mode
  :defer t
  :config
  (progn
    (use-package flymake-yaml)))

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

(use-package coffee-mode
  :defer t
  :mode ("\\.coffee$" . coffee-mode)
  :config
  (progn
    (use-package flymake-coffee)))

(use-package js2-mode
  :defer t
  :mode ("\\.js$" . js2-mode)
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

(use-package enh-ruby-mode
  :defer t
  :mode ("\\.rb$" . enh-ruby-mode)
  :interpreter ("ruby" . enh-ruby-mode)
  :init
  (progn
    ;; Add files to the global font-lock list for this mode.
    (add-to-list 'auto-mode-alist '("Capfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Cheffile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Guardfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Berksfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Godfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Gearfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Vagrantfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Gemfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.god$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.cap$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gear$" . enh-ruby-mode)))
  :config
  (progn
    (set 'enh-ruby-bounce-deep-indent 1)
    ;; Load up the required packages (minor modes).
    (use-package rspec-mode
      :diminish t
      :config
      (progn (add-hook 'dired-mode-hook 'rspec-dired-mode)))
    (use-package yard-mode
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'yard-mode)))
    (use-package ruby-tools)
    (use-package ruby-block
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'ruby-block-mode)))
    (use-package ruby-end
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'ruby-end-mode)))
    (use-package inf-ruby-mode
      :config
      (progn
        (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
        (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)))
    (use-package company
      :diminish t
      :config
      (progn
        (use-package company-inf-ruby)))
    (use-package robe
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'robe-mode)))
    (add-hook 'enh-ruby-mode-hook 'flymake-mode)))

(use-package go-mode
  :defer t
  :mode ("\\.go$" . go-mode)
  :config
  (progn
    (use-package go-autocomplete
      :config
      (add-to-list 'ac-modes 'go-mode))
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
 '(custom-safe-themes (quote ("e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "c5207e7b8cc960e08818b95c4b9a0c870d91db3eaf5959dd4eba09098b7f232b" default)))
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
