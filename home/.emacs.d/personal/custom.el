;;; custom --- Customized settings for my Emacs environment.
;;
;; Copyright © 2011-2015 John Bellone <jbellone@bellone.us>
;;
;;; Commentary:
;; Write something meaningful here.
;;; Code:

(setq whitespace-line-column 120)

(prelude-ensure-module-deps '(use-package))
(require 'use-package)

(setq org-ditaa-jar-path "/usr/share/java/ditaa.jar")
(org-babel-do-load-languages
 'org-babel-do-load-languages
 '((ditaa . t)))

(use-package ox-pandoc
  :config (progn
            (require 'ox-pandoc)
            (setq org-pandoc-command "~/.cabal/bin/pandoc")))

(use-package ox-reveal
  :config (progn
            (require 'ox-reveal)))

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

(use-package chruby
  :config (progn
            (require 'chruby)
            (chruby "2.2")))

(use-package company
  :config (progn
            (use-package company-inf-ruby)
            (add-hook 'after-init-hook 'global-company-mode)))

(use-package enh-ruby-mode
  :ensure autopair
  :mode ("\\.rb$" . enh-ruby-mode)
  :interpreter ("ruby" . enh-ruby-mode)
  :init (progn
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
  :config (progn
            (set 'enh-ruby-bounce-deep-indent 1)
            (use-package rubocop
              :config (progn
                        (add-hook 'enh-ruby-mode-hook 'rubocop-mode)))
            (use-package company-inf-ruby
              :diminish t
              :ensure company)
            (use-package yard-mode
              :diminish t
              :config (progn
                        (add-hook 'enh-ruby-mode-hook 'yard-mode)))
            (use-package ruby-block
              :diminish t
              :config (progn
                        (add-hook 'enh-ruby-mode-hook 'ruby-block-mode)))
            (use-package inf-ruby
              :config (progn
                        (autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
                        (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)))
            (use-package robe
              :diminish t
              :config (progn
                        (add-hook 'enh-ruby-mode-hook 'robe-mode)))))

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   (quote
    ("06538a1193c63f02cd0c7caee54105fa204e24a137ab9b56f86fdd8df6e5ddd4" "17fd8388e49d3055185e817ed3a2b7c955a2dda92b990f475c14a8e1d97dbe4b" "3328e7238e0f6d0a5e1793539dfe55c2685f24b6cdff099c9a0c185b71fbfff9" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
