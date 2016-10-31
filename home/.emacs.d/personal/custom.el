;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:
(setq whitespace-line-column 120)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(prelude-require-packages '(use-package))
(require 'use-package)

(define-key emacs-lisp-mode-map (kbd "<S-iso-lefttab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<backtab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<S-tab>")  'lisp-complete-symbol)

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
 '(TeX-engine (quote xetex))
 '(ansi-color-names-vector
   ["#28211c" "#cf6a4c" "#54be0d" "#f9ee98" "#5ea6ea" "#9b859d" "#5ea6ea" "#8a8986"])
 '(ansi-term-color-vector
   [unspecified "#28211c" "#cf6a4c" "#54be0d" "#f9ee98" "#5ea6ea" "#9b859d" "#5ea6ea" "#8a8986"] t)
 '(custom-safe-themes
   (quote
    ("40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" "e033c4abd259afac2475abd9545f2099a567eb0e5ec4d1ed13567a77c1919f8f" "e24679edfdea016519c0e2d4a5e57157a11f928b7ef4361d00c23a7fe54b8e01" "d1a42ed39a15a843cccadf107ee0242b5f78bfbb5b70ba3ce19f3ea9fda8f52d" "cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "b110da1a5934e91717b5c490709aba3c60eb4595194bbf9fdcbb97d247c70cfa" "db9feb330fd7cb170b01b8c3c6ecdc5179fc321f1a4824da6c53609b033b2810" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (ox-gfm terraform-mode markdown-mode ruby-block robe yard-mode ruby-electric enh-ruby-mode go-autocomplete flymake-yaml flymake-coffee ac-helm flymake-json chruby ssh-config-mode google-c-style gitattributes-mode use-package yaml-mode web-mode scss-mode geiser ensime scala-mode yari inf-ruby ruby-tools company-anaconda anaconda-mode flycheck-ocaml merlin utop tuareg company-auctex cdlatex auctex json-mode js2-mode haskell-mode gotest go-projectile go-eldoc company-go go-mode alchemist elixir-mode erlang rainbow-mode elisp-slime-nav slime coffee-mode cider clojure-mode rainbow-delimiters key-chord company helm-ag helm-descbinds helm-projectile helm smex ido-ubiquitous flx-ido vkill exec-path-from-shell zop-to-char zenburn-theme which-key volatile-highlights undo-tree smartrep smartparens smart-mode-line operate-on-number move-text magit projectile ov imenu-anywhere guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck expand-region epl easy-kill diminish diff-hl discover-my-major dash crux browse-kill-ring beacon anzu ace-window)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
