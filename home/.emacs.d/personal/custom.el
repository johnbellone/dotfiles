;;; custom.el --- Installs packages and configures them to make me happy.
;;; Commentary:
;;; Installs and configures packages to make my Emacs environment work.
;;; Code:

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(setq user-full-name "John Bellone"
      user-mail-address "john.bellone.jr@gmail.com")

(setq load-prefer-newer t
      gc-cons-threshold 50000000
      large-file-warning-threshold 100000000)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))

(setq whitespace-line-column 120
      scroll-margin 0
      scroll-step 1
      scroll-conservatively 100000
      scroll-preserve-screen-position 1
      prelude-whitespace nil)

(if (display-graphic-p)
    (progn
      (setq default-frame-alist '((width . 120) (height . 80)))
      (set-face-attribute 'default nil :family "Hack" :height 140 :weight 'normal)))

(prelude-require-packages '(use-package))
(require 'use-package)

(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-eighties t))

(define-key emacs-lisp-mode-map (kbd "<S-iso-lefttab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<backtab>")  'lisp-complete-symbol)
(define-key emacs-lisp-mode-map (kbd "<S-tab>")  'lisp-complete-symbol)

(use-package rjsx-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-indent-style 2)
  (setq js2-basic-offset 2)
  (setq js-indent-level 2))

(use-package org
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'flyspell-mode)
  :diminish visual-line-mode
  :diminish org-indent-mode
  :defer t
  :bind (("\C-c a" . org-agenda)
         ("\C-c c" . org-capture))
  :config
  (setq org-directory "~/org"
        org-default-notes-file "~/org/todo.org"
        org-agenda-files '("~/org/bloomberg.org"
                           "~/org/todo.org"
                           "~/org/personal.org"
                           "~/org/someday.org")
        org-refile-targets '((nil :maxlevel . 9)
                             (org-agenda-files :maxlevel . 3)))
  (defvar org-default-diary-file "~/org/diary.org")
  (setq org-startup-indented t
        org-startup-folded "showall"
        org-cycle-separator-lines 0
        org-tags-column 80
        org-agenda-tags-column org-tags-column
        org-agenda-sticky t
        org-src-fontify-natively t
        org-use-speed-commands t)
  (setq org-columns-default-format "%50ITEM(Task) %10Effort(Effort){:} %10CLOCKSUM %16TIMESTAMP_IA")
  (setq org-use-fast-todo-selection t)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
          (sequence "WAITING(w@/!)" "INACTIVE(i@/!)" "|" "CANCELLED(c@/!)" "MEETING")))
  (setq org-todo-keyword-faces
        '(("TODO" :foreground "red" :weight bold)
          ("NEXT" :foreground "blue" :weight bold)
          ("DONE" :foreground "forest green" :weight bold)
          ("WAITING" :foreground "orange" :weight bold)
          ("INACTIVE" :foreground "magenta" :weight bold)
          ("CANCELLED" :foreground "forest green" :weight bold)
          ("MEETING" :foreground "forest green" :weight bold)))
  (setq org-todo-state-tags-triggers
        '(("CANCELLED" ("CANCELLED" . t))
          ("WAITING" ("WAITING" . t))
          ("INACTIVE" ("WAITING") ("INACTIVE" . t))
          (done ("WAITING") ("INACTIVE"))
          ("TODO" ("WAITING") ("CANCELLED") ("INACTIVE"))
          ("NEXT" ("WAITING") ("CANCELLED") ("INACTIVE"))
          ("DONE" ("WAITING") ("CANCELLED") ("INACTIVE"))))
  (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h)))
  (defvar org-capture-templates
    '(("t" "Task" entry (file org-default-notes-file "Tasks")
       "* TODO %?\n%u\n")
      ("m" "Meeting" entry (file org-default-notes-file)
       "* MEETING with %? :MEETING:\n%t")
      ("d" "Diary" entry (file+datetree "~/org/diary.org")
       "* %?\n%U\n" :clock-in t :clock-resume t)
      ("D" "Daily Log" entry (file "~/org/daily-log.org")
       "* %u %?\n*Summary*: \n\n*Problem*: \n\n*Insight*: \n\n*Tomorrow*: ")
      ("i" "Idea" entry (file org-default-notes-file)
       "* %? :IDEA: \n%u")
      ("n" "Next Task" entry (file+headline org-default-notes-file "Tasks")
       "** NEXT %? \nDEADLINE: %t")))
  (setq org-refile-use-outline-path t
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm
        org-archive-location "archive/%s_archive::")
  (defvar org-archive-file-header-format "#+FILETAGS: ARCHIVE\nArchived entries from file %s\n")
  (setq org-enforce-todo-dependencies t
        org-agenda-inhibit-startup nil
        org-agenda-dim-blocked-tasks nil)
  (setq org-agenda-time-grid
        '((daily today require-timed)
          "----------------"
          (800 1200 1600 2000))))
                                      
(use-package gitattributes-mode :ensure t)
(use-package gitconfig-mode :ensure t)
(use-package gitignore-mode :ensure t)
(use-package google-c-style
  :config
  (progn
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent)))
(use-package ssh-config-mode :ensure t)

(when (eq system-type "darwin")
  (set-face-attribute 'default nil :family "Inconsolata-dz")
  (set-face-attribute 'default nil :height 140)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)
  (ns-set-resource nil "ApplePressAndHoldEnabled" "NO")
  (use-package osx-browse :ensure t)
  (use-package osx-clipboard :ensure t)
  (use-package osx-lib :ensure t)
  (use-package osx-pseudo-daemon :ensure t))

(use-package company)
(use-package company-inf-ruby
  :after company
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package json-mode)
(use-package flymake-json :after json-mode)

(use-package helm)
(use-package ac-helm
  :after helm
  :config (add-to-list 'ac-modes 'helm-mode))

(use-package coffee-mode)
(use-package flymake-coffee :after coffee-mode)

(use-package yaml-mode)
(use-package flymake-yaml :after yaml-mode)

(use-package go-mode)
(use-package go-autocomplete
  :after go-mode
  :config (add-to-list 'ac-modes 'go-mode))
(use-package go-eldoc :after go-mode)

(use-package salt-mode)

(use-package jinja2-mode
  :mode ("\\.jinja$" . jinja2-mode))

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
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'ruby-electric-mode))
(use-package yard-mode
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'yard-mode))
(use-package robe
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'robe-mode))
(use-package ruby-block
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'ruby-block-mode))
(use-package inf-ruby
  :after enh-ruby-mode
  :config (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode))

;; http://www.emacswiki.org/emacs/EmacsClient#WMFocus
(add-hook 'server-switch-hook
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (when server-buffer-clients
              (local-set-key (kbd "C-x k") 'server-edit))))

;;; custom.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes (quote (base16-zenburn)))
 '(custom-safe-themes
   (quote
    ("9be1d34d961a40d94ef94d0d08a364c3d27201f3c98c9d38e36f10588469ea57" "ec3e6185729e1a22d4af9163a689643b168e1597f114e1cec31bdb1ab05aa539" "69e7e7069edb56f9ed08c28ccf0db7af8f30134cab6415d5cf38ec5967348a3c" "100eeb65d336e3d8f419c0f09170f9fd30f688849c5e60a801a1e6addd8216cb" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "fee4e306d9070a55dce4d8e9d92d28bd9efe92625d2ba9d4d654fc9cd8113b7f" "3be1f5387122b935a26e02795196bc90860c57a62940f768f138b02383d9a257" "6145e62774a589c074a31a05dfa5efdf8789cf869104e905956f0cbd7eda9d0e" "4feee83c4fbbe8b827650d0f9af4ba7da903a5d117d849a3ccee88262805f40d" "6daa09c8c2c68de3ff1b83694115231faa7e650fdbb668bc76275f0f2ce2a437" "fede08d0f23fc0612a8354e0cf800c9ecae47ec8f32c5f29da841fe090dfc450" "8e51e44e5b079b2862335fcc5ff0f1e761dc595c7ccdb8398094fb8e088b2d50" "25c06a000382b6239999582dfa2b81cc0649f3897b394a75ad5a670329600b45" "85e6bb2425cbfeed2f2b367246ad11a62fb0f6d525c157038a0d0eaaabc1bfee" "50d07ab55e2b5322b2a8b13bc15ddf76d7f5985268833762c500a90e2a09e7aa" "12670281275ea7c1b42d0a548a584e23b9c4e1d2dabb747fd5e2d692bcd0d39b" "aea30125ef2e48831f46695418677b9d676c3babf43959c8e978c0ad672a7329" "36282815a2eaab9ba67d7653cf23b1a4e230e4907c7f110eebf3cdf1445d8370" "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d" "16dd114a84d0aeccc5ad6fd64752a11ea2e841e3853234f19dc02a7b91f5d661" "dd4628d6c2d1f84ad7908c859797b24cc6239dfe7d71b3363ccdd2b88963f336" "a62f0662e6aa7b05d0b4493a8e245ab31492765561b08192df61c9d1c7e1ddee" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (base16-theme fish-completion fish-mode osx-pseudo-daemon osx-browse nginx-mode toml-mode flycheck-clang-analyzer ac-clang clang-format company-c-headers csharp-mode ac-js2 discover-js2-refactor js2-highlight-vars js2-refactor rjsx-mode scss-mode typescript-mode jq-mode js-auto-beautify js-doc json-rpc jsx-mode gitignore-templates cmake-mode powershell csv-mode orca org-agenda-property org-doing org-ref osx-clipboard osx-lib osx-plist osx-trash org-projectile-helm docker docker-api docker-compose-mode docker-tramp dockerfile-mode groovy-mode flycheck-plantuml plantuml-mode protobuf-mode markdown-mode ac-c-headers ac-cider ac-etags ac-html ac-inf-ruby ace-flyspell cider-decompile cider-eval-sexp-fu cider-hydra cider-profile cider-spy clj-refactor cljr-helm clojure-mode-extra-font-locking flycheck-clojure inf-clojure org-ac org-autolist org-journal org-projectile company-inf-ruby zop-to-char zenburn-theme yari yard-mode which-key web-mode volatile-highlights vkill use-package undo-tree ssh-config-mode smex smartrep smartparens smart-mode-line slime salt-mode ruby-tools ruby-electric ruby-block robe rainbow-mode rainbow-delimiters racer ov operate-on-number move-text magit key-chord json-mode jinja2-mode imenu-anywhere ido-completing-read+ helm-projectile helm-descbinds helm-ag guru-mode grizzl gotest google-c-style god-mode go-projectile go-autocomplete gitignore-mode gitconfig-mode gitattributes-mode git-timemachine gist geiser flymake-yaml flymake-json flymake-coffee flycheck-rust flx-ido expand-region exec-path-from-shell enh-ruby-mode elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux counsel company-go company-auctex company-anaconda coffee-mode cider chruby cdlatex cargo browse-kill-ring beacon anzu ace-window ac-helm)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(plantuml-jar-path "/usr/local/Cellar/plantuml/1.2018.1/libexec/plantuml.jar")
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
