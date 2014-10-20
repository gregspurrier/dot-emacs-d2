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
(setq ring-bell-function 'ignore)

;; Look and  Feel
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

;; Ace Jump Mode
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Region selection and operation
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region) ; Terminal equivalent of C-=

(require 'change-inner)
(global-set-key (kbd "C-c i") 'change-inner)
(global-set-key (kbd "C-c o") 'change-outer)

(defun lispy-mode-setup ()
  (highlight-parentheses-mode t)
  (paredit-mode)
  (local-set-key (kbd "C-c )") 'paredit-forward-slurp-sexp)) ; Terminal equivalent of C-)

(add-hook 'emacs-lisp-mode-hook 'lispy-mode-setup)
(add-hook 'clojure-mode-hook 'lispy-mode-setup)
(add-hook 'cider-repl-mode-hook 'lispy-mode-setup)

(add-hook 'prog-mode-hook
          (lambda ()
            (if (window-system)
                (progn
                  (setq fci-rule-column 110)
                  (setq fci-rule-color "orange")
                  (fci-mode)))))

;; Clojure indentation rules
(eval-after-load 'clojure-mode
  '(define-clojure-indent
     (send-off 1)                                                    ; Core
     (GET 2) (POST 2) (PUT 2) (PATCH 2) (DELETE 2) (context 2)       ; Compojure
     (select 1) (insert 1) (update 1) (delete 1) (upsert 1) (join 1) ; Korma
     (clone-for 1)                                                   ; Enlive
     (up 1) (down 1) (alter 1) (table 1)                             ; Lobos
     ))
