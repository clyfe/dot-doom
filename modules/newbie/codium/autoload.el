;;; newbie/codium/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun newbie-codium/comment-dwim ()
  ;; From https://www.emacswiki.org/emacs/CommentingCode
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

;;;###autoload
(defun newbie-codium/scroll-up-in-place (n)
  (interactive "p")
  (forward-line (- 1 n))
  (unless (eq (window-end) (point-max))
    (scroll-up n)))

;;;###autoload
(defun newbie-codium/scroll-down-in-place (n)
  (interactive "p")
  (forward-line (- n 1))
  (unless (eq (window-start) (point-min))
    (scroll-down n)))
