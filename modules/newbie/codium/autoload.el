;;; newbie/codium/autoload.el -*- lexical-binding: t; -*-

;;; Comment

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

;;; Scroll in place

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

;;; Jumper follow

(require 'better-jumper)

;;;###autoload
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

;;;###autoload
(defun newbie-codium/better-jumper-advice (&rest _args)
  (newbie-codium/better-jumper-set-jump))

;;;###autoload
(defun newbie-codium/better-jumper-follow ()
  (progn (advice-add 'push-mark :after #'newbie-codium/better-jumper-advice)
         (advice-add 'switch-to-buffer :after #'newbie-codium/better-jumper-advice)
         (advice-add 'find-file :after #'newbie-codium/better-jumper-advice)
         (advice-add '+lookup/definition :after #'newbie-codium/better-jumper-advice)))

;;;###autoload
(defun newbie-codium/better-jumper-unfollow ()
  (progn (advice-remove 'push-mark #'newbie-codium/better-jumper-advice)
         (advice-remove 'switch-to-buffer #'newbie-codium/better-jumper-advice)
         (advice-remove 'find-file #'newbie-codium/better-jumper-advice)
         (advice-remove '+lookup/definition #'newbie-codium/better-jumper-advice)))
