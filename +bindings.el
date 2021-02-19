;;; $DOOMDIR/+cua.el -*- lexical-binding: t; -*-

;; Extended CUA mode bindings!

;; CUA Mode
(cua-mode t)
(setq cua-keep-region-after-copy t)

;; Helper
(defun cua-key (key sym)
  (define-key cua-global-keymap key sym))

;; Tabs
(cua-key (kbd "C-<prior>") 'centaur-tabs-backward)
(cua-key (kbd "C-<next>") 'centaur-tabs-forward)

;; Code navigation
(cua-key (kbd "M-RET") '+lookup/definition)
(cua-key (kbd "M-<left>") 'better-jumper-jump-backward)
(cua-key (kbd "M-<right>") 'better-jumper-jump-forward)

;; Movement
(cua-key (kbd "<home>") 'doom/backward-to-bol-or-indent)
(cua-key (kbd "<end>") 'doom/forward-to-last-non-comment-or-eol)

;; Redo
(cua-key (kbd "C-S-z") 'undo-fu-only-redo)

;; Files
(cua-key (kbd "C-o") '+default/find-file-under-here) ;g
(cua-key (kbd "C-s") 'save-buffer)
(cua-key (kbd "C-w") 'kill-this-buffer)
(cua-key (kbd "C-S-t") 'recentf-open-most-recent-file)

;; Find
(cua-key (kbd "C-f") '+default/search-buffer)
(cua-key (kbd "C-S-f") '+default/search-project)

;; More
(cua-key (kbd "C-d") 'duplicate-thing)
(cua-key (kbd "C-S-e") '+treemacs/toggle)

;; Escape cancel
(cua-key [escape] 'keyboard-escape-quit)
(define-key company-active-map [escape] 'company-abort)
