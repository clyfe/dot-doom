;;; $DOOMDIR/+cua.el -*- lexical-binding: t; -*-

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Cursor
(setq-default cursor-type 'bar)
(blink-cursor-mode +1)

;; Tabs
(setq centaur-tabs-set-icons nil)

;; Treemacs
(setq treemacs-width 25)
(add-hook! treemacs-mode (text-scale-adjust -1))

;; No revert confirm
(setq git-gutter:ask-p nil)
