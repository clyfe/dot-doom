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
(defun newbie-codium/scroll-down-in-place (n)
  "Scroll down keeping the point in place."
  (interactive "p")
  (forward-line (- 1 n))
  (unless (eq (window-end) (point-max))
    (scroll-up n)))

;;;###autoload
(defun newbie-codium/scroll-up-in-place (n)
  "Scroll up keeping the point in place."
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

;;; Deselect arrows

(defvar newbie-codium/shift-selection-just-deactivated-mark nil)

;;;###autoload
(defun newbie-codium/handle-shift-selection-before ()
  (if (and (not (and shift-select-mode this-command-keys-shift-translated))
           (eq (car-safe transient-mark-mode) 'only))
      (setq newbie-codium/shift-selection-just-deactivated-mark t)))

;;;###autoload
(defun newbie-codium/call-interactively-after (&rest _args)
  (if newbie-codium/shift-selection-just-deactivated-mark
      (setq newbie-codium/shift-selection-just-deactivated-mark nil)))

;;;###autoload
(defun newbie-codium/left-char-around (f &rest args)
  "If text selected, on pressing left arrow deselects and moves point to left of
  selection."
  (if newbie-codium/shift-selection-just-deactivated-mark
      (goto-char (min (mark) (point)))
    (apply f args)))

;;;###autoload
(defun newbie-codium/right-char-around (f &rest args)
  "If text selected, on pressing left arrow deselects and moves point to right
  of selection."
  (if newbie-codium/shift-selection-just-deactivated-mark
      (goto-char (max (mark) (point)))
    (apply f args)))

;;; Duplicate thing

;;;###autoload
(defun newbie-codium/duplicate-thing (n)
  "Like `duplicate-thing' but maintains the cursor column."
  (interactive "P")
  (let ((col (current-column)))
    (duplicate-thing n)
    (forward-line -1)
    (goto-char (+ (point) col))
    (deactivate-mark)))

;;; ON/OFF

;;;###autoload
(defun newbie-codium/advices-add ()
  "Enables advices when `newbie-codium' mode is activated."
  (progn
    ;;; Jumper follow
    (advice-add 'push-mark :after #'newbie-codium/better-jumper-advice)
    (advice-add 'switch-to-buffer :after #'newbie-codium/better-jumper-advice)
    (advice-add 'find-file :after #'newbie-codium/better-jumper-advice)
    (advice-add '+lookup/definition :after #'newbie-codium/better-jumper-advice)

    ;; Deselect arrows
    (advice-add 'handle-shift-selection :before #'newbie-codium/handle-shift-selection-before)
    (advice-add 'call-interactively :after #'newbie-codium/call-interactively-after)
    (advice-add 'left-char :around #'newbie-codium/left-char-around)
    (advice-add 'right-char :around #'newbie-codium/right-char-around)))

;;;###autoload
(defun newbie-codium/advices-remove ()
  "Remove advices when `newbie-codium' mode is deactivated."
  (progn
    ;;; Jumper follow
    (advice-remove 'push-mark #'newbie-codium/better-jumper-advice)
    (advice-remove 'switch-to-buffer #'newbie-codium/better-jumper-advice)
    (advice-remove 'find-file #'newbie-codium/better-jumper-advice)
    (advice-remove '+lookup/definition #'newbie-codium/better-jumper-advice)

    ;; Deselect arrows
    (advice-remove 'handle-shift-selection #'newbie-codium/handle-shift-selection-before)
    (advice-remove 'call-interactively #'newbie-codium/call-interactively-after)
    (advice-remove 'left-char #'newbie-codium/left-char-around)
    (advice-remove 'right-char #'newbie-codium/right-char-around)))
