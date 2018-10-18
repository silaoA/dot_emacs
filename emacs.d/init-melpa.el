;; =================== emacs.d/init-(m)elpa.el =====================
;; initialization for site-lisp package
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-melpa.el ...")
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
;; for package archive & install
(setq package-user-dir (concat emacsd "/melpa"))
(package-initialize) ;; You might already have this line
;; NOW you can (require) your ELPA packages and configure them as normal

;; =======  through package.el install ==========
;; == auto-complete ==
(message "setting up auto-complete ...")
(require 'auto-complete)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories (concat ac-dir "/dict"))
(ac-config-default)
;; (setq ac-ignore-case t)  ;;ignore case
;;(defun open-ac-dir()
;;  (interactive)
;;  (find-file ac-dir))
(defun ac-hide-help ()
  (interactive)
  (setq ac-use-quick-help nil))

(defun ac-show-help ()
  (interactive)
  (setq ac-use-quick-help t))

;; ===== smex ====
(message "setting up smex ...")
(require 'smex)   ;; 无其他依赖
(smex-initialize) ;; Can be omitted. This might cause a (minimal) delay
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; === sr-speedbar ===
(when (display-graphic-p)
  ;; GUI version (or (eq window-system 'w32) (eq window-system 'x))
  (message "GUI version Emacs, setting up sr-speedbar ...")
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
  (message "GUI version Emacs, setting up smex ...")
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
(message "setting up python-mode ...")
(setq py-install-directory (concat package-user-dir "/python-mode-20181008.1836"))
(add-to-list 'load-path py-install-directory)
(require 'python-mode)
;; by default, the function 'python-mode is associated with
;; the package python.el. The following changes that to python-mode.el
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-to-list 'interpreter-mode-alist '("python3" . python-mode))
(add-to-list 'interpreter-mode-alist '("ipython3" . python-mode))
;; python-shell-interpreter是python.el中的变量，不是python-mode.el
;; python-mode.el指定py-python-command、py-python3-command、py-ipython-command
;; 以及对应的-args参数
;; python-mode下python文件的shebang将被C-c C-c选作运行buffer的解释器，优先级
;; 高于py-shell-name，设置py-force-py-shell-name-p则忽略shebang
;;(setq python-shell-interpreter "ipython3"
;;	  python-shell-interpreter-args "--simple-prompt -i")
(setq python-shell-interpreter "python3")
;; (setq py-python3-command "python3")
;; (setq py-shell-name 'py-python3-command)
;; (setq py-python3-command-args "-i")
(defun setup-python-mode-hook()
  "python-mode hook setu for `add-hook`"
  (interactive)
  ;;(guess-style-guess-tab-width)
  (setq-default indent-tabs-mode t) ;;defined in C source code
  (setq-default tab-width 4)
  (setq-default py-indent-tabs-mode t)
;;  (set-variable 'python-indent-offset 4)
  ;; (set-variable 'python-indent-guess-indent-offset nil)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace)
  ;;(global-set-key [remap py-forward-block] 'smart-comment-or-uncomment-region)
)
(add-hook 'python-mode-hook 'setup-python-mode-hook)

;; == emacs-jedi == require EPC and auto-complete
(message "setting up emacs-jedi ...")
(setq jedi-dir (concat package-user-dir "/jedi-20160425.2156"))
(setq jedi-core-dir (concat package-user-dir "/jedi-core-20170121.610"))
;; (setq jedi-dir (concat site-lisp-dir "/emacs-jedi"))
;; (add-to-list 'load-path jedi-dir)
(setq jedi:server-command (list "python3" (concat jedi-core-dir "/jediepcserver.py")))
(add-hook 'python-mode-hook 'jedi:setup)
(autoload 'jedi:setup "jedi" nil t)
(setq jedi:complete-on-dot t)            ; optional
(setq jedi:setup-keys t)                 ; recommended keybinds
(setq jedi:key-complete (kbd "C tab"))

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

(message "加载init-mepla.el完成")
;; init-melpa ENDS HERE
(provide 'init-melpa)
