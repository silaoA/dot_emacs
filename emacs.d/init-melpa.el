;; =================== .emacs.d/init-(m)elpa.el =====================
;; initialization for site-lisp package
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(require 'package) ;; You might already have this line
(setq-local local-elpa-mirror-dir (concat emacsd "/local-melpa/"))
(setq package-archives  '(
	 ("local-melpa" . local-elpa-mirror-dir)
	 ("ec-melpa" . "http://elpa.emacs-china.org/melpa/")
	 ("ec-melpastable" . "http://elpa.emacs-china.org/melpa-stable/")
) )

;;(add-to-list 'package-archives
;;          '("popkit" . "https://elpa.popkit.org/packages/") )
;;(add-to-list 'package-archives
;;          '("zl-melpa" . "http://elpa.zilongshanren.com/melpa/") )
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
(add-to-list 'package-archives '("ec-gnu" . "http://elpa.emacs-china.com/gnu/") ) )
;; ==  cl - common lisp extension ==
(require 'cl)
;; for package archive & install
(setq package-user-dir (concat emacsd "/melpa"))
(package-initialize) ;; You might already have this line
;; NOW you can (require) your ELPA packages and configure them as normal

;; =======  through package.el install ==========
;; == auto-complete ==
(require 'auto-complete)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories (concat ac-dir "/dict"))
(ac-config-default)
;; (setq ac-ignore-case t)  ;;ignore case
;;(defun open-ac-dir()
;;  (interactive)
;;  (find-file ac-dir))

;; ===== smex ====
(require 'smex)   ;; 无其他依赖
(smex-initialize) ;; Can be omitted. This might cause a (minimal) delay
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; === sr-speedbar ===
(when (display-graphic-p)
  ;; GUI version (or (eq window-system 'w32) (eq window-system 'x))
  (require 'sr-speedbar)  ;; 无其他依赖
  (setq sr-speedbar-right-side nil)
  (setq sr-speedbar-width 20)
  (setq dframe-update-speed t)
  (setq speedbar-use-images nil)
  (add-hook 'speedbar-mode-hook (lambda () (linum-mode -1) (line-number-mode -1))) ;; linum off
  ;;(add-hook 'after-init-hook '(lambda () (sr-speedbar-toggle)));; toggle on init
)

;; === tabbar ===
(when (display-graphic-p)
  ;; GUI version (or (eq window-system 'w32) (eq window-system 'x))
  (require 'tabbar)
  (setq tabbar-use-images nil)
  ;; 设置默认主题: 字体, 背景和前景颜色，大小
  (set-face-attribute 'tabbar-default nil
                  ;;  :family "Consoles"
                    :background "gray80"
                    :foreground "gray30"
                    :height 0.8
                    )
  (when (eq system-type 'windows-nt)
   (set-face-attribute 'tabbar-default nil
					  :family "Consoles"
					  )
  )
  ;; 设置左边按钮外观：外框框边大小和颜色
  ;;(set-face-attribute 'tabbar-button nil
  ;;                    :inherit 'tabbar-default
  ;;				      :background "DarkGoldenrod"
  ;;                    :box '(:line-width 1 :color "yellow90")
  ;;                    )
  ;; 设置当前tab外观：颜色，字体，外框大小和颜色
  ;;(set-face-attribute 'tabbar-selected nil
  ;;                    :inherit 'tabbar-default
  ;;                    :foreground "DarkGreen"
  ;;                    :background "LightGoldenrod"
  ;;                    :box '(:line-width 2 :color "DarkGoldenrod")
  ;;                    :overline "black"
  ;;                    :underline "black"
  ;;                    :weight 'bold
  ;;                    )
  ;; 设置非当前tab外观：外框大小和颜色
  ;;(set-face-attribute 'tabbar-unselected nil
  ;;                    :inherit 'tabbar-default
  ;;                    :box '(:line-width 2 :color "#00B2BF")
  ;;                    )
  (global-set-key [(control tab)] 'tabbar-forward-tab)
  (global-set-key [(control shift tab)] 'tabbar-backward-tab)
  (tabbar-mode t)
  ;;(add-hook 'after-init-hook '(lambda () (tabbar-ruler-up)))
)

;; ==== yafolding ====
;; (defvar yafolding-mode-map
;;   (let ((map (make-sparse-keymap)))
;;     (define-key map (kbd "<C-S-return>") #'yafolding-hide-parent-element)
;;     (define-key map (kbd "<C-M-return>") #'yafolding-toggle-all)
;;     (define-key map (kbd "<C-return>") #'yafolding-toggle-element)
;;     map))
;; (add-hook 'prog-mode-hook (lambda () (yafolding-mode)) )
;; (require 'yafolding)
;; stupid

;; == python-mode.el ==
;; (require 'python-mode)
;; (autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
(add-hook 'python-mode-hook (lambda ()
	;; (guess-style-guess-tab-width)
	(setq-default indent-tabs-mode nil) ;;defined in C source code
	(setq-default tab-width 4)
	(setq-default py-indent-tabs-mode t)
	(set-variable 'python-indent-offset tab-width)
	;; (set-variable 'python-indent-guess-indent-offset nil)
	(add-to-list 'write-file-functions 'delete-trailing-whitespace)
  ;;(global-set-key [remap py-forward-block] 'smart-comment-or-uncomment-region)
))

;; == emacs-jedi == require EPC and auto-complete
;;(setq jedi-dir (concat site-lisp-dir "/emacs-jedi"))
;;(add-to-list 'load-path jedi-dir)
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(autoload 'jedi:setup "jedi" nil t)
;;(setq jedi:complete-on-dot t)            ; optional
;;(setq jedi:setup-keys t)                 ; recommended keybinds
;; (setq jedi:key-complete (kbd "C tab"))

;; ===== py-autopep8 =======
;; (require 'py-autopep8)
;; (add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;; (require 'py-yapf)
;; (add-hook 'python-mode-hook 'py-yapf-enable-on-save)

;; == elpy ==
;;(require 'elpy)
;; (add-hook 'python-mode-hook '(lambda () (elpy-enable t) ) )
;;(add-hook 'elpy-mode-hook  '(lambda ()
;;			(setq python-check-command nil)
;;			(setq elpy-rpc-backend "jedi")
			;; (when (executable-find "ipython") (elpy-use-ipython) )
			;; (when (el-get-package-installed-p 'flycheck)
			;; (when (package-installed-p 'flycheck)
			;;   (setq elpy-default-minor-modes
			;; 		(remove 'flymake-mode elpy-default-minor-modes) )
			;; )
;;			(add-to-list 'elpy-project-ignored-directories "*-env")
;;			(setq elpy-modules '(elpy-module-sane-defaults
;;			elpy-module-company
;;			elpy-module-eldoc
;;			elpy-module-highlight-indentation
;;			elpy-module-pyvenv
;;			elpy-module-yasnippet))
;;			(set (make-local-variable 'comment-inline-offset) 2)
;;			(auto-complete-mode -1)
;;))

;; init-melpa ENDS HERE
(provide 'init-melpa)
