;;; $DOOMDIR/+functions.el -*- lexical-binding: t; -*-

;; CUA utility functions!

;; From https://www.emacswiki.org/emacs/CommentingCode
(defun +cua/comment-dwim ()
  "Like `comment-dwim' but comments lines at beginning."
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

(defun +cua/handle-shift-selection ()
  "Activate/deactivate mark depending on invocation thru shift translation.
This function is called by `call-interactively' when a command
with a `^' character in its `interactive' spec is invoked, before
running the command itself.
If `shift-select-mode' is enabled set the mark and activate the region
temporarily, unless it was already set in this way.
Otherwise, if the region has been activated temporarily,
deactivate it, and restore the variable `transient-mark-mode' to
its earlier value.
Compared to `handle-shift-selection' this does not mind
`this-command-keys-shift-translated'."
  (cond ((and shift-select-mode)
         (unless (and mark-active
		      (eq (car-safe transient-mark-mode) 'only))
	   (setq-local transient-mark-mode
                       (cons 'only
                             (unless (eq transient-mark-mode 'lambda)
                               transient-mark-mode)))
           (push-mark nil nil t)))
        ((eq (car-safe transient-mark-mode) 'only)
         (setq transient-mark-mode (cdr transient-mark-mode))
         (if (eq transient-mark-mode (default-value 'transient-mark-mode))
             (kill-local-variable 'transient-mark-mode))
         (deactivate-mark))))

(defun +cua/select-left-word ()
  "Move `left-word' and select."
  (interactive)
  (+cua/handle-shift-selection)
  (left-word))

(defun +cua/select-right-word ()
  "Move `right-word' and select."
  (interactive)
  (+cua/handle-shift-selection)
  (right-word))
