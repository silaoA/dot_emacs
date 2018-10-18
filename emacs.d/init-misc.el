;;=================== emacs.d/init-misc.el =======================
;; init for emacs misc
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-misc.el ...")
;; === coding system settings（UTF-8编码） ===
;;(setq codec 'utf-8)
;;(setq locale-coding-system codec)
;;(when (eq system-type 'windows-nt) (set-language-environment 'Chinese-GB) )
;;(set-terminal-coding-system codec)
;;(set-default-coding-systems codec)
;;(set-keyboard-coding-system codec)
;;(set-clipboard-coding-system codec)
;;(set-buffer-file-coding-system codec)
;;(set-selection-coding-system codec)
;;(unless (eq system-type 'windows-nt) (set-selection-coding-system codec))
;;(modify-coding-system-alist 'process "*" codec)

;; Tumashu 编码配置
;;(use-package mule
;;  :ensure nil
;;  :config

  (set-language-environment "UTF-8")
  (set-buffer-file-coding-system 'utf-8-unix)
  (set-clipboard-coding-system 'utf-8-unix)
  (set-file-name-coding-system 'utf-8-unix)
  (set-keyboard-coding-system 'utf-8-unix)
  (set-next-selection-coding-system 'utf-8-unix)
  (set-selection-coding-system 'utf-8-unix)
  (set-terminal-coding-system 'utf-8-unix)

  (when (eq system-type 'windows-nt)
;;  (eq window-system 'w32) ;; (when (display-graphic-p) )
    (set-file-name-coding-system 'gbk-dos)
    (set-selection-coding-system 'gbk-dos)
    (set-next-selection-coding-system 'gbk-dos)
    (set-clipboard-coding-system 'gbk-dos)
  )
;;)

;; === cl cl-lib (common lisp)包，Emacs Lisp推荐cl-lib，因cl过时
(require 'cl)
(require 'cl-lib)

;; misc 其他杂类
(setq make-backup-files nil)   ;;关闭文件自动备份
;; file菜单下增加最近访问文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; ======= ui related =======
(electric-pair-mode 1)  ;;括号自动匹配补全
(when (display-graphic-p)       ;; GUI version
  (setq mouse-wheel-progressive-speed nil)  ;; don't accelerate scrolling
  (setq mouse-wheel-follow-mouse 't)        ;; scroll window under mouse
  (setq scroll-step 1)               ;; keyboard scroll one line at a time
  (setq scroll-margin 0)        ;; stop autoscroll when mouse is close to margi
)

;; ==== editing =====
(global-set-key (kbd "M-g") 'goto-line) ;; default is M-g g
(electric-indent-mode -1)  ;; 取消掉electric-indent-mode，与其他mode可能不兼容
(global-set-key (kbd "C-SPC") 'nil) ;;取消control+space键设为mark
;;(global-set-key (kbd "s-SPC") 'set-mark-command) ;;用win+space键来set-mark
;; use mouse to copy thing automatically
;;(setq mouse-drag-copy-region t)
(delete-selection-mode 1) ;; delete selection after insert 插入时删除选中内容
(setq-default kill-whole-line t)    ;; 在行首 C-k 时，同时删除该行
;; ======== copy line =======
(defun copy-line ()
  (interactive)
  (kill-ring-save (save-excursion
                    (back-to-indentation)
                    (point))
                  (line-end-position))
  (message "line copied")
)

;; ====== dos CR LF -> CR  ======
(defun hide-dos-eol ()
  "hide ^M in text file containing DOS line endings."
  (interactive)
  (unless buffer-display-table
	(setq buffer-display-table (make-display-table) ) )
  (aset buffer-display-table ?\^M [])
  (message "^M (LF) in DOS line endings HIDDEN")
)
(defun remove-dos-eol ()
  "remove ^M in text file containing DOS line endings (CR LF -> LF)."
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match ""))
  (message "^M (LF) in DOS line endings REMOVED")
)

;; ======== minibuffer ========
(fset 'yes-or-no-p 'y-or-n-p) ;; y-n replace yes-no
(setq-default major-mode 'text-mode)  ;; 默认major mode

;; ===== buffer topic(dired, ibuffer, ido-mode, windmove) =====
(message "setting up dired ...")
(require 'dired)
(setq dired-recursive-deletes (quote top))  ;; allow delete nonempty directory
(setq dired-recursive-copies (quote always))  ;; allow copy recursively
(defun dired-up-dir () 
  "get parent directory in dired mode"
  (interactive)
  (find-alternate-file "..")
)
(define-key dired-mode-map (kbd "^") 'dired-up-dir) ;; 绑定键到"^"
(defalias 'list-buffers 'ibuffer) ; make ibuffer default

(message "setting up ido ...")
(require 'ido)
(ido-mode 1)
;; show choices seperation
(if (version< emacs-version "25")
    (progn
          (make-local-variable 'ido-separator)
          (setq ido-separator " | ")
	)
	(progn
	      (make-local-variable 'ido-decorations)
	      (setf (nth 2 ido-decorations) " | ")
	)
)
(ido-everywhere t)
;; show any name that has the chars you typed
(setq ido-enable-flex-matching t)
;; use current pane for newly opened file
(setq ido-default-file-method 'selected-window)
;; use current pane for newly switched buffer
(setq ido-default-buffer-method 'selected-window)
;; stop ido from suggesting when naming new file
(define-key (cdr ido-minor-mode-map-entry) [remap write-file] nil)
(setq
 ido-ignore-buffers  '("\\` "  "^\*Back" ".*Completions\*" "^\*Ido" "^\*trace"
				   "^\*compilation" "^\*GTAGS" "^session\.*")
 ;ido-work-directory-list '("~/" "~/Desktop" "~/Documents" "~src")
 ido-case-fold  t
 ido-enable-last-directory-history t ; remember last used dirs
 ido-max-work-file-list      30   ; remember many
 ido-use-filename-at-point nil
 ido-use-url-at-point nil
 ;ido-max-prospects 8              ; don't spam my minibuffer
 ;ido-confirm-unique-completion t ; wait for RET, even with unique completion
 ;ido-save-directory-list-file (concat dss-ephemeral-dir "ido.last"))"'")
)

(message "setting up windmove ...")
(require 'windmove)
;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)
;; when cursor is on edge, move to the other side, as in a torus space
(setq windmove-wrap-around t )

(message "加载init-misc.el完成")
;; init-misc ENDS HERE
(provide 'init-misc)
