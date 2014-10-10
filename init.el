(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))
(package-initialize)

;; General customizations
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-auto-revert-mode t)
(setq inhibit-startup-message t)
(setq ispell-program-name "aspell")
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
(setq require-final-newline t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Look and Feel
(load-theme 'zenburn t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(when (window-system)
  (scroll-bar-mode -1)
  (set-frame-font "Input 12"))
(column-number-mode t)

;; OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(defun lispy-mode-setup ()
  (highlight-parentheses-mode t)
  (paredit-mode))

(add-hook 'emacs-list-mode-hook 'lispy-mode-setup)
(add-hook 'clojure-mode-hook 'lispy-mode-setup)
(add-hook 'cider-repl-mode-hook 'lispy-mode-setup)
