;;=================== emacs.d/init-ui =======================
;; init for emacs UI
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-ui.el ...")
;; frame size 窗口大小
(when (display-graphic-p)   ;; GUI version
  (setq default-frame-alist '((width . 84) (height . 32) (menu-bar-lines . 1)))
  (setq default-fill-column 84);;把 fill-column 设为 84， 这样的文字更好读
)
(toggle-truncate-lines 1)    ;;正数折行，负数不折行
;; make the title infomation more useful
(setq frame-title-format
;; (list "GNU Emacs " emacs-version "@" system-name "   " '(buffer-file-name "%f" "%b"))
(list "GNU " invocation-name " " emacs-version "@" system-name " " '(buffer-file-name "%f"))
  ;;window-system 和 system-type 暂无法加载出来
  ;; (list "GNU Emacs " emacs-version "(" run-os "." run-x ")")
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; '(custom-enabled-themes (quote (misterioso)))
 ;;'(global-linum-mode t)
 )

(global-linum-mode t)
(column-number-mode t)   ;;列号
(when (display-graphic-p)   ;; GUI version
  (tool-bar-mode -1)            ;;工具栏
)
;; (display-time-mode 1)         ;;启用时间显示设置，在minibuffer上面的那个杠上
;; (setq display-time-24hr-format t) ;;时间使用24小时制
;;(format-time-string "%Y-%m-%d %H:%M:%S")
;; (setq display-time-day-and-date t)     ;;时间显示包括日期和具体时间
;; (setq display-time-format "%Y-%m-%d %H:%M:%S")

;; (setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置
;; (setq display-time-interval 1);;时间的变化频率，单位多少来着？
;; (setq display-time-default-load-average nil)

;; 括号匹配
(show-paren-mode t)
(setq show-paren-style 'parentheses)

(global-font-lock-mode t) ;; 语法高亮
(setq font-lock-maximum-decoration t)
(global-visual-line-mode 1) ; line wrapping 卷行

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.

 ;; 字体 consolas
;; '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 113 :width normal))))
 ;; 行号风格
 '(linum ((t (:background "SystemWindowFrame" :weight normal :height 0.9 :width normal)))))

;; ==== font for English and 中文汉字 ====
(when (or (eq system-type 'windows-nt) (eq system-type 'cygwin) )
	(when (display-graphic-p)   ;; GUI version
	;; Setting English Font
	 (set-face-attribute 'default nil :font "Consolas 11")
	;; Chinese Font
	 (dolist (charset '(kana han symbol cjk-misc bopomofo) )
		     (set-fontset-font (frame-parameter nil 'font)
		     charset (font-spec :family "Microsoft Yahei" :size 14))
	 )
	)
)

(setq ring-bell-function (lambda () t))  ;; 关闭屏幕闪动
(global-hl-line-mode 1) ;; highlight cursor line高亮当前行

(transient-mark-mode t) ;; hilight mark area


;; 空白显示   minor mode
;; (require 'whitespace)
;; (autoload 'whitespace-mode "whitespace" "Toggle whitespace visualization."  t)
;; (autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)
;; (global-whitespace-mode)
;; 要展示的空白类型
(setq whitespace-style '(empty spaces tabs space-mark tab-mark newline-mark))
;; 符号显示映射
;; Glyph  Unicode Code Point(Decimal)  Unicode Name
;;  ·	            183                 MIDDLE DOT
;;  ¶               182                 PILCROW SIGN
;;  ?              8629                 DOWNWARDS ARROW WITH CORNER LEFTWARDS
;;  ?	            8617                LEFTWARDS ARROW WITH HOOK
;;  ?	            9166                RETURN SYMBOL
;;  ?	            9655                WHITE RIGHT POINTING TRIANGLE
;;  ?	            9654                BLACK RIGHT-POINTING TRIANGLE
;;  →              8594                RIGHTWARDS ARROW
;;  ?               8614                RIGHTWARDS ARROW FROM BAR
;;  ?               8677                RIGHTWARDS ARROW TO BAR
;;  ?               8680                RIGHTWARDS WHITE ARROW
(setq whitespace-display-mappings '(
;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
  (space-mark 32 [183] [46]) ; 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
  (newline-mark 10 [8629 10]) ;
  (tab-mark 9 [8594 9] [92 9]) ; tab
))

;; ==== color-theme-solarized ===
;; (defvar color-theme-solarized-dir (concat site-lisp-dir "/emacs-color-theme-solarized") )
;;(add-to-list custom-theme-load-path 'color-theme-solarized-dir)
;;(load-theme 'solarized t)

(message "加载init-ui.el完成")
;; init-ui ENDS HERE
(provide 'init-ui)
