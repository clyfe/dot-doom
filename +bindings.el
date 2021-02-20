;;; $DOOMDIR/+cua.el -*- lexical-binding: t; -*-

;; Extended CUA mode bindings!

;; From https://www.emacswiki.org/emacs/CommentingCode
(defun my/comment-dwim ()
  (interactive)
  (let ((start (line-beginning-position))
        (end (line-end-position)))
    (when (or (not transient-mark-mode) (region-active-p))
      (setq start (save-excursion
                    (goto-char (region-beginning))
                    (beginning-of-line)
                    (point))
            end (save-excursion
                  (goto-char (region-end))
                  (end-of-line)
                  (point))))
    (comment-or-uncomment-region start end)))

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

;; Selection
(cua-key (kbd "C-a") 'mark-whole-buffer)

;; Redo
(cua-key (kbd "C-S-z") 'undo-fu-only-redo)

;; Files
(cua-key (kbd "C-o") '+default/find-file-under-here)
(cua-key (kbd "C-k C-o") '+default/dired)
(cua-key (kbd "C-s") 'save-buffer)
(cua-key (kbd "C-w") 'kill-this-buffer)
(cua-key (kbd "C-S-t") 'recentf-open-most-recent-file)

;; Find
(cua-key (kbd "C-f") '+default/search-buffer)
(cua-key (kbd "C-S-f") '+default/search-project)

;; More
(cua-key (kbd "C-d") 'duplicate-thing)
(cua-key (kbd "C-/") 'my/comment-dwim)
(cua-key (kbd "C-S-e") '+treemacs/toggle)
(cua-key (kbd "C-b") '+treemacs/toggle)

;; Escape cancel
(cua-key [escape] 'keyboard-escape-quit)
(add-hook! company-mode
  (define-key company-active-map [escape] 'company-abort))
(define-key smartparens-mode-map (kbd "M-d") 'sp-kill-hybrid-sexp)
