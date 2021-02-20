;;; newbie/paredit/config.el -*- lexical-binding: t; -*-

(load! "mode")

;; Paredit simplified
(add-hook! smartparens-mode
  (newbie-paredit-mode t))
