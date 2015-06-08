;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:
(set-frame-font "Inconsolata-dz")
(setq whitespace-line-column 120)
(tool-bar-mode -1)
(menu-bar-mode -1)

(prelude-require-packages '(use-package))
(require 'use-package)

(use-package diminish :ensure t)
(use-package gitattributes-mode :defer t :ensure t)
(use-package gitconfig-mode :defer t :ensure t)
(use-package gitignore-mode :defer t :ensure t)
(use-package google-c-style :defer t :ensure t)
(use-package ssh-config-mode :defer t :ensure t)

(use-package osx-browse :ensure t)
(use-package osx-clipboard :ensure t)
(use-package osx-lib :ensure t)
(use-package osx-pseudo-daemon :ensure t)

(use-package org
  :defer t
  :ensure t
  :config
  (lambda ()
    (use-package org-ac :ensure t)
    (use-package org-autolist :ensure t)
    (use-package org-grep :ensure t)
    (use-package org-journal :ensure t)
    (use-package org-pandoc :ensure t)
    (use-package org-projectile :ensure t)
    (use-package orgit :ensure t)
    (use-package ox-pandoc :ensure t)
    (use-package ox-reveal :ensure t)))

(use-package chruby
  :ensure t
  :config
  (chruby "2.2"))

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package json-mode
  :defer t
  :ensure t
  :config
  (use-package flymake-json :ensure t))

(use-package helm
  :ensure t
  :config
  (lambda ()
    (use-package ac-helm
      :ensure t
      :config
      (add-to-list 'ac-modes 'helm-mode))))

(use-package coffee-mode
  :defer t
  :ensure t
  :config
  (use-package flymake-coffee :ensure t))

(use-package yaml-mode
  :defer t
  :ensure t
  :config
  (use-package flymake-yaml :ensure t))

(use-package go-mode
  :defer t
  :ensure t
  :config
  (lambda ()
    (use-package go-autocomplete
      :ensure t
      :config
      (add-to-list 'ac-modes 'go-mode))
    (use-package go-eldoc :ensure t)
    (add-hook 'go-mode-hook
              (lambda ()
                (add-hook 'before-save-hook 'gofmt-before-save)))))

(use-package enh-ruby-mode
  :ensure t
  :mode ("\\.rb$" . enh-ruby-mode)
  :interpreter ("ruby" . enh-ruby-mode)
  :config
  (lambda ()
    (set 'enh-ruby-bounce-deep-indent 1)
    (use-package company-inf-ruby :diminish t)
    (use-package ruby-electric
      :ensure t
      :diminish t
      :config
      (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode))
    (use-package yard-mode
      :ensure t
      :diminish t
      :config
      (add-hook 'enh-ruby-mode-hook 'yard-mode))
    (use-package robe
      :ensure t
      :diminish t
      :config
      (add-hook 'enh-ruby-mode-hook 'robe-mode))
    (use-package ruby-block
      :ensure t
      :diminish t
      :config
      (add-hook 'enh-ruby-mode-hook 'ruby-block-mode))
    (use-package inf-ruby
      :ensure t
      :config
      (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))))

;; http://www.emacswiki.org/emacs/EmacsClient#WMFocus
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

(provide 'custom)
;;; custom.el ends here
