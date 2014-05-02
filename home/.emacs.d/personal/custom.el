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

(prelude-ensure-module-deps '(use-package))
(require 'use-package)

;;(use-package chruby
;;  :config (progn (chruby "ruby-2.0.0")))
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

;; There are a few variables that I am going to always want to modify.  These
;; are generally personalized overrides of the defaults.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("a53714de04cd4fdb92ed711ae479f6a1d7d5f093880bfd161467c3f589725453" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "25cfeb08ce2a19741a98639f57f77218badee1523eaec5d1b32831c7f9ed50d8" "70cf411fbf9512a4da81aa1e87b064d3a3f0a47b19d7a4850578c8d64cac2353" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "c5207e7b8cc960e08818b95c4b9a0c870d91db3eaf5959dd4eba09098b7f232b" default)))
 '(fci-rule-color "#383838")
 '(fic-highlighted-words (quote ("BUG" "TODO" "NOTE" "KLUDGE" "HACK" "FIX" "FIXME")))
 '(flymake-max-parallel-syntax-checks nil)
 '(flymake-run-in-place nil)
 '(legalese-default-author "John Bellone <john.bellone.jr@gmail.com>")
 '(legalese-default-license (quote mit))
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(temporary-file-directory "/tmp")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

(provide 'custom)
;;; custom.el ends here
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "apple" :family "Inconsolata")))))
