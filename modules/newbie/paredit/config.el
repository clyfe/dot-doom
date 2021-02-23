;;; newbie/paredit/config.el -*- lexical-binding: t; -*-

(load! "mode")

;; Paredit simplified

(add-hook! emacs-lisp-mode
  (newbie-paredit-mode t))

(add-hook! lisp-mode
  (newbie-paredit-mode t))

(if (fboundp 'clojure-mode)
    (add-hook! clojure-mode
      (newbie-paredit-mode t)))
