(defun authorize-comment ()
  (interactive)
  (insert (concat "steggy: " (format-time-string "%Y-%m-%d:"))))

(keymap-global-set "C-x ." 'authorize-comment)

(defun github-for-source (use-current-branch)
  (interactive "P")
  (when-let
      (containing-directory (expand-file-name (locate-dominating-file (buffer-file-name) ".git")))
    (let* ((project-name (first (last (s-split "/" containing-directory t))))
           (path (s-chop-prefix containing-directory (buffer-file-name)))
           (current-line (cadr (s-split " " (what-line))))
           (branch (if use-current-branch (magit-get-current-branch) "master"))
           )
      (kill-new (concat
        "https://github.internal.digitalocean.com/digitalocean/"
        project-name
        "/blob/" branch "/"
        path
        "#L" current-line)))))


(defun goto-current-tickler-day ()
  (interactive)
  (cl-multiple-value-bind (month day) (s-split " " (format-time-string "%B %d"))
    (find-file (concat home common-notes-prefix "tickler/" month "/" (first (last (s-split "^0" day))) ".org"))))

(setq journal-template "* ")

(defun goto-current-journal-day ()
  (interactive)
  (cl-multiple-value-bind (month day year) (s-split " " (format-time-string "%m %d %Y"))
    (find-file (concat home common-notes-prefix "/gtd/" "journal/" year "-" month "-" (first (last (s-split "^0" day))) ".org"))
    (if (eq (buffer-size (current-buffer)) 0)
        (insert journal-template))
    )
  )

(defun ms/make-right-tiny (&optional arg)
  (interactive "P")
  (let ((increase (or current-prefix-arg 100)))
    (enlarge-window-horizontally increase)
  ))

(defun ms/make-left-tiny (&optional arg)
  (interactive "P")
  (let ((increase (or current-prefix-arg 100)))
    (enlarge-window-horizontally (* -1 increase))
    ))

(defun push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-~") 'push-mark-no-activate)

(defun ms/pearing ()
  (interactive)
  (setq ms/old-height (face-attribute 'default :height))
  (set-face-attribute 'default nil :height 170))

(defun ms/unpearing()
  (interactive)
  (set-face-attribute 'default nil :height ms/old-height))


(defun jira-example()
  (interactive)
  (exwm-input--fake-key 'e)
  (exwm-input--fake-key 's)
  (exwm-input--fake-key 'q)
  (sit-for 0.5)
  (exwm-input--fake-key 'e)
  (exwm-input--fake-key 's)
  (exwm-input--fake-key 'v))

(defun random-thing()
  (interactive)
  (exwm-input--fake-key 'C-f)
  (sit-for 0.25)
  (--map (exwm-input--fake-key it) '(u n r e v i e w))
  (exwm-input--fake-key 'return)
  (exwm-input--fake-key 'escape)
  (sit-for 0.25)
  (exwm-input--fake-key 'return)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'down)
  (exwm-input--fake-key 'return))

;; (keymap-set key-translation-map "C-*" 'event-apply-super-modifier)
