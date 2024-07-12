;;; -*- lexical-binding: t; -*-

(defun ms/dabbrev-capf ()
  "Dabbrev completion function for `completion-at-point-functions'."
  (let* ((abbrev (dabbrev--abbrev-at-point))
         (beg (progn (search-backward abbrev) (point)))
         (end (progn (search-forward abbrev) (point)))
	 (ignore-case-p (dabbrev--ignore-case-p abbrev))
	 (list 'uninitialized)
         (table
          (lambda (s p a)
            (if (eq a 'metadata)
                `(metadata (cycle-sort-function . ,#'identity)
                           (category . dabbrev))
              (when (eq list 'uninitialized)
                (save-excursion
                  ;;--------------------------------
                  ;; New abbreviation to expand.
                  ;;--------------------------------
                  (setq dabbrev--last-abbreviation abbrev)
                  ;; Find all expansion
                  (let ((completion-list
                         (list (first (dabbrev--find-all-expansions abbrev ignore-case-p))))
                        (completion-ignore-case ignore-case-p))
                    (or (consp completion-list)
                        (user-error "No dynamic expansion for \"%s\" found%s"
                                    abbrev
                                    (if dabbrev--check-other-buffers
                                        "" " in this-buffer")))
                    (setq list
                          (cond
                           ((not (and ignore-case-p dabbrev-case-replace))
                            completion-list)
                           ((string= abbrev (upcase abbrev))
                            (mapcar #'upcase completion-list))
                           ((string= (substring abbrev 0 1)
                                     (upcase (substring abbrev 0 1)))
                            (mapcar #'capitalize completion-list))
                           (t
                            (mapcar #'downcase completion-list)))))))
              (complete-with-action a list s p)))))
    (list beg end table)))

;; Jank that lets you do dabbrev in vterm. Worth it!
(defun vterm-dabbrev-completion (&optional args)
  (interactive "P")
  (if (equal major-mode 'vterm-mode)
      (let ((inhibit-read-only t)
            (in-dabbrev t))
        (ms/dabbrev-completion args))
    (ms/dabbrev-completion args)))

;; Jank that lets you do dabbrev in vterm. Worth it!
(defun vterm-regular-dabbrev-completion (&optional args)
  (interactive "P")
  (if (equal major-mode 'vterm-mode)
      (let ((inhibit-read-only t)
            (in-dabbrev t))
        (dabbrev-completion args))
    (dabbrev-completion args)))

(defun vterm-ivy-completion-in-region-action (orig-fun &rest args)
  (if (equal major-mode 'vterm-mode)
      (let ((inhibit-read-only t))
        (dotimes (i (length dabbrev--last-abbreviation))
          (vterm-send-backspace))
        (vterm-insert (car args)))
    (apply orig-fun args)))

(require 'dabbrev)
(defun ms/dabbrev-completion (&optional arg)
  "Completion on current word.
Like \\[dabbrev-expand] but finds all expansions in the current buffer
and presents suggestions for completion.

With a prefix argument ARG, it searches all buffers accepted by the
function pointed out by `dabbrev-friend-buffer-function' to find the
completions.

If the prefix argument is 16 (which comes from \\[universal-argument] \\[universal-argument]),
then it searches *all* buffers."
  (interactive "*P")
  (dabbrev--reset-global-variables)
  (setq dabbrev--check-other-buffers (and arg t))
  (setq dabbrev--check-all-buffers
        (and arg (= (prefix-numeric-value arg) 16)))
  (let ((completion-at-point-functions '(ms/dabbrev-capf)))
    (completion-at-point)))

(advice-add 'ivy-completion-in-region-action :around #'vterm-ivy-completion-in-region-action)
(keymap-set vterm-mode-map "C-M-/" 'vterm-dabbrev-completion)
(keymap-set vterm-mode-map "M-/" 'vterm-regular-dabbrev-completion)

(with-eval-after-load 'org-gcal
  (defun silence-org-gcal-sync (orig-fun &rest args)
    (let ((inhibit-message t)
          (message-log-max nil))
      (apply orig-fun args)))

  (advice-add 'org-gcal-sync :around #'silence-org-gcal-sync))
