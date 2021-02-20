;;; newbie/paredit/mode.el -*- lexical-binding: t; -*-

(define-minor-mode newbie-paredit-mode
  "Paredit simplified."
  :keymap (let ((map (make-sparse-keymap)))
            ;; Movement
            (define-key map (kbd "C-<left>") 'sp-backward-sexp)
            (define-key map (kbd "C-<right>") 'sp-forward-sexp)

            ;; Selection
            (define-key map (kbd "C-S-<left>") 'newbie-paredit/select-left-word)
            (define-key map (kbd "C-S-<right>") 'newbie-paredit/select-right-word)

            ;; Copy as kill
            (define-key map (kbd "M-d") 'sp-kill-hybrid-sexp)

            map))
