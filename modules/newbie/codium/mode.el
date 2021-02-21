;;; newbie/codium/mode.el -*- lexical-binding: t; -*-

(define-minor-mode newbie-codium-mode
  "Extended CUA mode of sorts."
  :global t
  :keymap (let ((map (make-sparse-keymap)))
            ;; Escape cancel
            (define-key map [escape] 'keyboard-escape-quit)

            ;; Tabs
            (define-key map (kbd "C-<prior>") 'centaur-tabs-backward)
            (define-key map (kbd "C-<next>") 'centaur-tabs-forward)

            ;; Code navigation
            (define-key map (kbd "M-RET") '+lookup/definition)
            (define-key map (kbd "M-<left>") 'better-jumper-jump-backward)
            (define-key map (kbd "M-<right>") 'better-jumper-jump-forward)

            ;; Movement
            (define-key map (kbd "<home>") 'doom/backward-to-bol-or-indent)
            (define-key map (kbd "<end>") 'doom/forward-to-last-non-comment-or-eol)

            ;; Selection
            (define-key map (kbd "C-a") 'mark-whole-buffer)

            ;; Redo
            (define-key map (kbd "C-S-z") 'undo-fu-only-redo)

            ;; Files
            (define-key map (kbd "C-o") '+ivy/projectile-find-file)
            (define-key map (kbd "C-k C-o") '+default/dired)
            (define-key map (kbd "C-s") 'save-buffer)
            (define-key map (kbd "C-w") 'kill-this-buffer)
            (define-key map (kbd "C-S-t") 'recentf-open-most-recent-file)
            (define-key map (kbd "C-r") 'counsel-buffer-or-recentf)

            ;; Find
            (define-key map (kbd "C-f") '+default/search-buffer)
            (define-key map (kbd "C-S-f") '+default/search-project)

            ;; Replace
            (define-key map (kbd "C-h") 'anzu-query-replace)
            (define-key map (kbd "C-S-h") 'projectile-replace)

            ;; More
            (define-key map (kbd "C-d") 'duplicate-thing)
            (define-key map (kbd "C-/") 'newbie-codium/comment-dwim)
            (define-key map (kbd "C-S-e") '+treemacs/toggle)
            (define-key map (kbd "C-b") '+treemacs/toggle)

            map))
