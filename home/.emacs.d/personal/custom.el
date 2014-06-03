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

(set-face-attribute 'default nil :height 160)

(prelude-ensure-module-deps '(use-package))
(require 'use-package)

(require 'chruby)
(chruby "ruby-2.0.0")

(use-package chruby
  :config (progn (chruby "ruby-2.0.0")))
(use-package company
  :config
  (progn
    (use-package company-inf-ruby)
    (add-hook 'after-init-hook 'global-company-mode)))
(use-package diminish)
(use-package flyspell-lazy)
(use-package yaml-mode
  :config
  (progn
    (use-package flymake-yaml)))

(use-package markdown-mode :ensure markdown-mode+)

(use-package coffee-mode
  :mode ("\\.coffee$" . coffee-mode)
  :config
  (progn
    (use-package flymake-coffee)))

(use-package js2-mode
  :mode ("\\.js$" . js2-mode)
  :config
  (progn
    (use-package flymake-gjshint)))

(use-package json-mode
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
  :ensure autopair
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
    (add-to-list 'auto-mode-alist '("Thorfile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("Rakefile\\'" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.god$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.task$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.cap$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
    (add-to-list 'auto-mode-alist '("\\.gear$" . enh-ruby-mode)))
  :config
  (progn
    (set 'enh-ruby-bounce-deep-indent 1)

    (use-package rubocop
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'rubocop-mode)))
    (use-package company-inf-ruby
      :diminish t
      :ensure company)
    (use-package yard-mode
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'yard-mode)))
    (use-package ruby-block
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'ruby-block-mode)))
    (use-package inf-ruby
      :config
      (progn
        (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
        (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)))
    (use-package robe
      :diminish t
      :config
      (progn (add-hook 'enh-ruby-mode-hook 'robe-mode)))))

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

;; http://www.emacswiki.org/emacs/EmacsClient#WMFocus
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(provide 'custom)
;;; custom.el ends here
