;; ==================== emacs.d/init-coding =================
;; initialization for coding
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-coding.el ...")
;; (defvar site-lisp-dir (concat emacsd "/site-lisp"))
;; (add-to-list 'load-path site-lisp-dir)

(setq-default tab-width 4) ;; emacs 23.1, 24.2, default to 8
(setq tab-width 4)
(setq-default tab-stop-list (number-sequence 4 120 4))
(setq indent-tabs-mode t) ;;tab不使用空格缩进，nil则为控股
;; (global-set-key (kbd "RET") 'newline-and-indent)
(define-key prog-mode-map (kbd "RET") 'newline-and-indent)
(electric-indent-mode 1)   	;;return key also do indent globally

(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

(setq auto-mode-alist (append '(
				("\\.css\\'" . css-mode)
                ("\\.S\\'" . asm-mode)
                ("\\.C\\w*\\'" . c-mode)
                ("\\.md\\'" . markdown-mode)
                ("\\.markdown\\'" . markdown-mode)
				("\\.md\\'" . markdown-mode)
                ("\\.svg\\'" . html-mode)
                ("\\.pas\\'" . delphi-mode)
				("\\.py\\'" . python-mode)
                ("\\.txt\\'" . org-mode)
                ) auto-mode-alist))

(defvar hs-special-modes-alist
  (mapcar 'purecopy
  '((c-mode "{" "}" "/[*/]" nil nil)
    (c++-mode "{" "}" "/[*/]" nil nil)
    (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
    (java-mode "{" "}" "/[*/]" nil nil)
    (js-mode "{" "}" "/[*/]" nil))
))

(add-hook 'prog-mode-hook (lambda ()
   ;; (guess-style-guess-tab-width)
   (setq tab-width 4)
   (setq-default indent-tabs-mode t) ;;defined in C source code
   (setq-default tab-width 4)
   (setq-default tab-stop-list (number-sequence 4 120 4))
   (add-to-list 'write-file-functions 'delete-trailing-whitespace)
   ;; (global-whitespace-mode)
   ;;(whitespace-mode)
))

;; == cedet shipped with Emacs 24 =====
;; (require 'cedet)
;; (global-ede-mode 1)         ; Enable the Project management system
;;(semantic-load-enable-code-helpers) ;Enable prototype help and smart completion
;;(global-srecode-minor-mode 1)        ; Enable template insertion menu
;; (setq semantic-default-submodes '(
;; 				  global-semanticdb-minor-mode
;;                   global-semantic-idle-scheduler-mode
;;                   global-semantic-idle-summary-mode
;;                   global-semantic-idle-completions-mode
;;                   global-semantic-decoration-mode
;;                   global-semantic-highlight-func-mode
;;                   global-semantic-stickyfunc-mode
;;                   global-semantic-mru-bookmark-mode
;;                   global-semantic-tag-folding-mode
;; 				  global-semantic-show-unmatched-syntax-mode
;; ))
;;enable semantic
;; (semantic-mode 1)

;; ===    shell mode ===
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;; (add-hook 'prog-mode-hook (lambda() (setq tab-width 4)))

;; == c mode ==
(setq c-default-style "linux"
      c-basic-offset 4)
(setq-default c-basic-offset 4
               tab-width 4
               indent-tabs-mode t)
(add-hook 'c-mode-common-hook (lambda () (c-toggle-auto-state 1) ))

;; coding-func.el
(require 'coding-func)
(global-set-key (kbd "C-c C-q") 'smart-comment-or-uncomment-region)
;; (add-hook 'outline-minor-mode-hook 'my-outline-minor-mode-hook)
(global-set-key (kbd "<S-tab>") 'un-indent-by-removing-4-spaces)
(global-set-key [remap yank] 'yank-and-indent)

;;(add-hook 'python-mode-hook
;;(add-hook 'py-mode-hook			;;我也不知道为何加在py-mode-hook里才正常
;;(global-set-key [remap py-forward-block] 'smart-comment-or-uncomment-region)
;;   (require 'whitespace)
;;    (whitespace-mode)
;;)

(message "加载init-coding完毕")
;; init-coding ENDS HERE
(provide 'init-coding)
