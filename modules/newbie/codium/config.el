;;; newbie/codium/config.el -*- lexical-binding: t; -*-

(load! "mode")

(add-hook! company-mode
  (define-key company-active-map [escape] 'company-abort))

;; CUA
(cua-mode t)
(setq cua-keep-region-after-copy t)

;; Extended CUA
(newbie-codium-mode t)
