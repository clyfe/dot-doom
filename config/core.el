;; Start fullscreen
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

;; Continue last session
(add-hook 'emacs-startup-hook 'doom/quickload-session)

;; Exit no confirm
(setq confirm-kill-emacs nil)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; Cursor
(setq-default cursor-type 'bar)

;; Tabs
(setq centaur-tabs-set-icons nil)
