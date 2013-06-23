(tool-bar-mode -1)
(menu-bar-mode -1)
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Cheffile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Godfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gearfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Procfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))

(prelude-ensure-module-deps
 '(powerline rbenv robe puppet-mode ruby-electric
   ruby-hash-syntax ruby-interpolation ruby-test-mode
   ruby-tools rspec-mode rubocop wgrep yaml-mode yard-mode
   apache-mode coffee-mode coffee-fof crontab-mode csv-mode
   csharp-mode dired+ enh-ruby-mode feature-mode js2-mode
   fic-mode flyspell-lazy google-c-style haml-mode jump
   magit-gh-pulls magit-push-remote nginx-mode flymake-ruby
   flymake-json flymake-yaml ruby-end ruby-block))

(add-hook 'enh-ruby-mode-hook
          (lambda ()
            (yard-mode)
            (turn-on-fic-mode)
            (flymake-mode)
            (ruby-end-mode)
            (ruby-block-mode)
            (ruby-interpolation-mode)))

(custom-set-variables
 '(fic-highlighted-words (quote ("FIXME" "TODO" "BUG" "KLUDGE" "NOTE"))))

(powerline-default-theme)

(provide 'custom)
;;; custom.el ends here
