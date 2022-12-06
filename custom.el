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
;; So pray for this Guardian of our growth and choose him well, for if he be not truly blessed, then our designs are surely frivolous and our future but a tragic waste of hope.
;; Bless our best and adore for he doth bear our measure to the Cosmos.

;; Meditation brings wisdom, lack of wisdom leaves ignorance.
;; Know well what leads you forward and what holds you back.

;; By the sweat of thy brow shalt thou eat bread, till thou return unto the ground;
;; for out of it wast thou taken:
;; for dust thou art, and unto dust shalt thou return
")

(setq org-icalendar-combined-agenda-file (concat (getenv "HOME") "/org.ics"))

(custom-set-variables
'(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "brown"))))
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(plantuml-jar-path "/home/msteger/Downloads/plantuml-1.2021.16.jar")
 '(rainbow-delimiters-depth-1-face ((t (:foreground "red"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "green"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "violet"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "brown"))))
 '(safe-local-variable-values
   '((checkdoc-package-keywords-flag)
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
 )

;; Set things up for e.g. copyright assignment
(setq user-full-name "Michael Steger")
(setq user-mail-address "mikeysteger@gmail.com")

;; Some quick face customizations at the end
(set-face-attribute 'default nil :height 140)
(set-face-attribute 'mode-line-inactive nil :background "#353839")
(set-face-attribute 'minibuffer-prompt nil :foreground "#CDCDCD")
(set-face-attribute 'ivy-current-match nil :background "#353839")

(setq-default global-mode-string '(("    "
  (:eval
   (smudge-remote-player-status-text)))
 battery-mode-line-string))

(setq flycheck-go-staticcheck-executable "/home/msteger/work/cthulhu/docode/bin/staticcheck")
(setq flycheck-go-errcheck-executable "/home/msteger/work/cthulhu/docode/bin/errcheck")
(setq flycheck-go-golint-executable "/home/msteger/work/cthulhu/docode/bin/golint")
(setq lsp-gopls-server-path "/home/msteger/work/cthulhu/docode/bin/gopls")

;; Can make gifs from emacs! Needs imagemagick/gifsicle/scrot
(use-package gif-screencast
  :straight (gif-screencast :type git :host gitlab :repo "ambrevar/emacs-gif-screencast"))

;; Memento mori string about how much of the year is passed
(setq-default mode-line-format
              '("%e" "%l:%c " "  " (:eval display-time-string) (:eval (format "%2.1f " (* 100 (/ (calendar-day-number (calendar-current-date)) 365.0))))  mode-line-mule-info mode-line-client mode-line-modified mode-line-remote mode-line-frame-identification mode-line-buffer-identification
                (vc-mode vc-mode)
                sml/pre-modes-separator mode-line-modes (:eval (format "%5.2f " (/ (first (load-average)) 100.0))) mode-line-misc-info mode-line-end-spaces))


(defun format-pomidor-work ()
  (let ((time (if (pomidor--break (pomidor--current-state))
                  (pomidor--break-duration (pomidor--current-state))
                (pomidor--work-duration (pomidor--current-state))))
        (name (if (pomidor--break (pomidor--current-state))
                 "break"
               "work"
               )))
    (format "%s: %s" name (pomidor--format-duration time))))

(when (boundp 'pomidor-sound-tack)
  (push '(:eval (format-pomidor-work)) (nthcdr 2 mode-line-format)))

;; Set up go-playground correctly
(when (boundp 'go-playground-basedir)
  (setq go-playground-go-command "GO111MODULE=on go")
  (setq go-playground-basedir "/home/msteger/work/cthulhu/docode/src/do/playground"))
