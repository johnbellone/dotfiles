(tool-bar-mode -1)
(menu-bar-mode -1)
(add-to-list 'auto-mode-alist '("\\Capfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Cheffile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Godfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gearfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Procfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Vagrantfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Gemfile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\Rakefile$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\*.rb" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\*.god" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\*.rake" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\*.gemspec" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\*.gear" . enh-ruby-mode))

(prelude-ensure-module-deps
 '(powerline rbenv robe puppet-mode
   ruby-hash-syntax ruby-interpolation ruby-test-mode
   ruby-tools rspec-mode rubocop wgrep yaml-mode yard-mode
   apache-mode coffee-mode coffee-fof crontab-mode csv-mode
   csharp-mode dired+ enh-ruby-mode js2-mode
   fic-mode flyspell-lazy google-c-style haml-mode jump
   magit-gh-pulls magit-push-remote nginx-mode flymake-ruby
   flymake-json flymake-yaml ruby-end ruby-block))

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (yard-mode)
            (fic-mode)
            (flymake-mode)
            (ruby-end-mode)
            (ruby-block-mode)
            (ruby-interpolation-mode)))

(custom-set-variables
 '(fic-highlighted-words (quote ("FIXME" "TODO" "BUG" "KLUDGE" "NOTE"))))

(powerline-default-theme)

(provide 'custom)
;;; custom.el ends here