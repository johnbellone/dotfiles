;; Give me the full screen without any menu or toolbars.
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Setup syntax highlighting for files.
(add-to-list 'auto-mode-alist '("\\Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Cheffile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Berksfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Godfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gearfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Procfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.god$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gear$" . enh-ruby-mode))

(prelude-ensure-module-deps
 '(powerline rbenv robe puppet-mode
   ruby-hash-syntax ruby-interpolation ruby-test-mode
   ruby-tools rspec-mode rubocop wgrep yaml-mode yard-mode
   apache-mode coffee-mode coffee-fof crontab-mode csv-mode
   csharp-mode dired+ enh-ruby-mode js3-mode
   fic-mode flyspell-lazy google-c-style haml-mode jump
   magit-gh-pulls magit-push-remote nginx-mode flymake-ruby
   flymake-json flymake-yaml ruby-end))

(setq enh-ruby-program "/Users/jbellone/.rbenv/shims/ruby")
(setq enh-ruby-bounce-deep-indent 1)

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (yard-mode)
            (fic-mode)
            (flymake-mode)
            (ruby-end-mode)
            (robe-mode)
            (ruby-interpolation-mode)))

(push 'company-robe company-backends)

(powerline-default-theme)

(provide 'custom)
;;; custom.el ends here
