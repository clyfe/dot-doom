;;; newbie/codium/mode.el -*- lexical-binding: t; -*-

(require 'better-jumper)

(defun newbie-codium/better-jumper-set-jump (&optional pos)
  "Like `better-jumper-set-jump' but does not `push-mark'."
  (unless (or
           better-jumper--jumping
           (better-jumper--ignore-persp-change))
    ;; clear out intermediary jumps when a new one is set
    (let* ((struct (better-jumper--get-struct))
           (jump-list (better-jumper--get-struct-jump-list struct))
           (idx (better-jumper-jump-list-struct-idx struct)))
      (when (eq better-jumper-add-jump-behavior 'replace)
        (cl-loop repeat idx
                 do (ring-remove jump-list 0)))
      (setf (better-jumper-jump-list-struct-idx struct) -1))
    (save-excursion
      (when pos
        (goto-char pos))
      (better-jumper--push))))

(defun newbie-codium/better-jumper-advice (&rest _args)
  (newbie-codium/better-jumper-set-jump))

(defun newbie-codium/better-jumper-follow ()
  (progn (advice-add 'push-mark :after #'newbie-codium/better-jumper-advice)
         (advice-add 'switch-to-buffer :after #'newbie-codium/better-jumper-advice)
         (advice-add 'find-file :after #'newbie-codium/better-jumper-advice)
         (advice-add '+lookup/definition :after #'newbie-codium/better-jumper-advice)))

(defun newbie-codium/better-jumper-unfollow ()
  (progn (advice-remove 'push-mark #'newbie-codium/better-jumper-advice)
         (advice-remove 'switch-to-buffer #'newbie-codium/better-jumper-advice)
         (advice-remove 'find-file #'newbie-codium/better-jumper-advice)
         (advice-remove '+lookup/definition #'newbie-codium/better-jumper-advice)))

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

            ;; Scroll
            (define-key map (kbd "C-<up>") 'newbie-codium/scroll-up-in-place)
            (define-key map (kbd "C-<down>") 'newbie-codium/scroll-down-in-place)

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

            map)

  (if newbie-codium-mode
      (newbie-codium/better-jumper-follow)
    (newbie-codium/better-jumper-unfollow)))
