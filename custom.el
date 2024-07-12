;; Some fun quotes for the scratch buffer
(setq initial-scratch-message ";; Do you wrestle with dreams?
;; Do you contend with shadows?
;; Do you move in a kind of sleep?

;; Time has slipped away
;; Your life is stolen
;; You tarried with trifles
;; Victim of your folly

;; He’s the best of us.
;; The best of our best, the best that each of us will ever build or ever love.
;; So pray for this Guardian of our growth and choose him well, for if he be not truly blessed,
;; then our designs are surely frivolous and our future but a tragic waste of hope.
;; Bless our best and adore for he doth bear our measure to the Cosmos.

;; Meditation brings wisdom, lack of wisdom leaves ignorance.
;; Know well what leads you forward and what holds you back.

;; By the sweat of thy brow shalt thou eat bread, till thou return unto the ground;
;; for out of it wast thou taken:
;; for dust thou art, and unto dust shalt thou return

;; A great philosopher once said, that every change begins with a moment of lucidity.
;; In these moments a veil opens, one which normally shrouds all the unwelcome truths we are aware of,
;; but which we have buried deep within ourselves, where we cannot see them.
;; And it is only these moments in which we can make a decision.
;; The decision to either act, or to let the moment pass, until the veil seals itself again and we once more are the slaves of our habits.
")

(setq org-icalendar-combined-agenda-file (concat (getenv "HOME") "/org.ics"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((geiser-insert-actual-lambda)))
 '(org-agenda-files
   '("/home/msteger/Dropbox/national/gtd/todo.org" "/home/msteger/Dropbox/national/gtd/google-cal.org" "/home/msteger/Dropbox/national/gtd/refile-beorg.org" "/home/msteger/Dropbox/national/gtd/appointments.org" "/home/msteger/Dropbox/national/gtd/read-review.org" "/home/msteger/Dropbox/national/gtd/projects.org" "/home/msteger/Dropbox/national/gtd/inbox.org" "/home/msteger/Dropbox/national/gtd/office.org" "/home/msteger/Dropbox/national/gtd/calls.org"))
 '(plantuml-jar-path "/home/msteger/Downloads/plantuml-1.2021.16.jar")
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "brown"))))
 '(safe-local-variable-values
   '((eval progn
           (require 'lisp-mode)
           (defun emacs27-lisp-fill-paragraph
               (&optional justify)
             (interactive "P")
             (or
              (fill-comment-paragraph justify)
              (let
                  ((paragraph-start
                    (concat paragraph-start "\\|\\s-*\\([(;\"]\\|\\s-:\\|`(\\|#'(\\)"))
                   (paragraph-separate
                    (concat paragraph-separate "\\|\\s-*\".*[,\\.]$"))
                   (fill-column
                    (if
                        (and
                         (integerp emacs-lisp-docstring-fill-column)
                         (derived-mode-p 'emacs-lisp-mode))
                        emacs-lisp-docstring-fill-column fill-column)))
                (fill-paragraph justify))
              t))
           (setq-local fill-paragraph-function #'emacs27-lisp-fill-paragraph))
     (geiser-repl-per-project-p . t)
     (eval with-eval-after-load 'yasnippet
           (let
               ((guix-yasnippets
                 (expand-file-name "etc/snippets/yas"
                                   (locate-dominating-file default-directory ".dir-locals.el"))))
             (unless
                 (member guix-yasnippets yas-snippet-dirs)
               (add-to-list 'yas-snippet-dirs guix-yasnippets)
               (yas-reload-all))))
     (eval add-to-list 'completion-ignored-extensions ".go")
     (checkdoc-package-keywords-flag)
     (eval modify-syntax-entry 43 "'")
     (eval modify-syntax-entry 36 "'")
     (eval modify-syntax-entry 126 "'")
     (eval let
           ((root-dir-unexpanded
             (locate-dominating-file default-directory ".dir-locals.el")))
           (when root-dir-unexpanded
             (let*
                 ((root-dir
                   (expand-file-name root-dir-unexpanded))
                  (root-dir*
                   (directory-file-name root-dir)))
               (unless
                   (boundp 'geiser-guile-load-path)
                 (defvar geiser-guile-load-path 'nil))
               (make-local-variable 'geiser-guile-load-path)
               (require 'cl-lib)
               (cl-pushnew root-dir* geiser-guile-load-path :test #'string-equal))))
     (eval setq-local guix-directory
           (locate-dominating-file default-directory ".dir-locals.el"))))
 '(warning-suppress-log-types '(((yasnippet backquote-change))))
 '(warning-suppress-types '((comp))))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-mode-line-clock ((t (:foreground "light sky blue"))))
 '(tab-bar ((t (:background "#2a2e38" :foreground "white" :box nil)))))

;; Set things up for e.g. copyright assignment
(setq user-full-name "Michael Steger")
(setq user-mail-address "mikeysteger@gmail.com")

(defun pomidor--format-header (time state face)
  "Return formated header for TIME with FACE."
  (let ((freezed-time (plist-get state :session-ended)))
    (concat (pomidor--with-face (concat (pomidor--format-time (or freezed-time (current-time)))
                                        pomidor-header-separator)
                                'pomidor-time-face)
            (pomidor--with-face (pomidor--format-duration time)
                         'pomidor-timer-face)
            (when (eq major-mode 'pomidor-history-mode)
              (pomidor--with-face (concat pomidor-header-session-name-separator
                                          (format-time-string "%Y-%m-%d" freezed-time))
                                  'pomidor-date-face)))))
(set-face-attribute 'pomidor-time-face nil :height 3.0)

;; Some quick face customizations at the end
(set-face-attribute 'default nil :height 100)
(set-face-attribute 'mode-line-inactive nil :background "#353839")
(set-face-attribute 'minibuffer-prompt nil :foreground "#CDCDCD")
(set-face-attribute 'ivy-current-match nil :background "#353839")

(setq tab-bar-org-clock '())
(add-hook 'org-clock-in-hook #'(lambda () (push org-mode-line-string tab-bar-org-clock)))
(add-hook 'org-clock-out-hook #'(lambda () (pop tab-bar-org-clock)))

(defun tab-bar-info()
  (interactive)
  `((global menu-item (format-mode-line '((
                                    "																		"
                                    (:eval (format-pomidor-work))
                                    " "
                                    (:eval display-time-string)
                                    " "
                                    (:eval (propertize (format "%2.1f " (* 100 (/ (calendar-day-number (calendar-current-date)) 365.0)))'font-lock-face 'org-mode-line-clock))
                                    " "
                                    (:eval (format "%5.2f " (/ (first (load-average)) 100.0)))
                                    (:eval tab-bar-org-clock)
                                    ))) ignore)))

(defun tab-bar-right()
  (interactive)
  (format-mode-line '(((:eval
   (propertize (smudge-remote-player-status-text) 'font-lock-face 'org-mode-line-clock)
   )
 battery-mode-line-string))))

(setq tab-bar-format '(tab-bar-info tab-bar-format-align-right tab-bar-right))
(tab-bar-mode +1)

(setq flycheck-go-staticcheck-executable "/home/msteger/work/cthulhu/docode/bin/staticcheck")
(setq flycheck-go-errcheck-executable "/home/msteger/work/cthulhu/docode/bin/errcheck")
(setq flycheck-go-golint-executable "/home/msteger/work/cthulhu/docode/bin/golint")
(setq gofmt-command "gofmt")
(setq lsp-gopls-server-path "/home/msteger/work/cthulhu/docode/bin/gopls")
(setq dap-dlv-go-delve-path "/home/msteger/work/cthulhu/docode/bin/dlv")

(setq dap-lldb-debug-program "/gnu/store/chrwzab8icp9p3mswkr6glbxba89pm6s-lldb-15.0.5/bin/lldb-vscode")
;; ln -s /home/msteger/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust /rustc/935dc07218b4bf6e20231e44eb9263b612fd649b

;; Can make gifs from emacs! Needs imagemagick/gifsicle/scrot
(use-package gif-screencast
  :straight (gif-screencast :type git :host gitlab :repo "ambrevar/emacs-gif-screencast"))

;; Memento mori string about how much of the year is passed
(setq-default mode-line-format
              '("%e" "%l:%c " "  " (:eval display-time-string) " " (:eval (format-pomidor-work)) mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification
                (vc-mode vc-mode)
                sml/pre-modes-separator mode-line-modes (:eval (format "%5.2f " (/ (first (load-average)) 100.0))) mode-line-end-spaces))


(defun format-pomidor-work ()
  (let ((time (if (pomidor--break (pomidor--current-state))
                  (pomidor--break-duration (pomidor--current-state))
                (pomidor--work-duration (pomidor--current-state))))
        (face (if (pomidor--break (pomidor--current-state))
                 'pomidor-break-face
               'pomidor-work-face
               )))
    (propertize (format "%s" (pomidor--format-duration time)) 'font-lock-face face)))


;; Set up go-playground correctly
(when (boundp 'go-playground-basedir)
  (setq go-playground-go-command "GO111MODULE=on go")
  (setq go-playground-basedir "/home/msteger/work/cthulhu/docode/src/do/playground"))


(setq treesit-language-source-alist
   '((bash "https://github.com/tree-sitter/tree-sitter-bash")
     (cmake "https://github.com/uyha/tree-sitter-cmake")
     (css "https://github.com/tree-sitter/tree-sitter-css")
     (elisp "https://github.com/Wilfred/tree-sitter-elisp")
     (go "https://github.com/tree-sitter/tree-sitter-go")
     (html "https://github.com/tree-sitter/tree-sitter-html")
     (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
     (json "https://github.com/tree-sitter/tree-sitter-json")
     (make "https://github.com/alemuller/tree-sitter-make")
     (markdown "https://github.com/ikatyang/tree-sitter-markdown")
     (python "https://github.com/tree-sitter/tree-sitter-python")
     (toml "https://github.com/tree-sitter/tree-sitter-toml")
     (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
     (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
     (yaml "https://github.com/ikatyang/tree-sitter-yaml")))
