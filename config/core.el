;; Start fullscreen
(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

;; Continue last session
(add-hook 'emacs-startup-hook 'doom/quickload-session)

;; Exit no confirm
(setq confirm-kill-emacs nil)
