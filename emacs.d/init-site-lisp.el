;; ================= emacs.d/init-site-lisp.el ===================
;; initialization for site-lisp package
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-site-lisp.el ...")

;; == unicad ==
(require 'unicad)

;; === emacs-powerline ===
;; GUI 或者text terminal的版本在Windows和WSL中工作正常，但cygwin的版本显示不出来
;; (when (not (eq system-type 'cygwin) )
  ;; (add-to-list 'load-path (concat site-lisp-dir "/emacs-powerline") )
  ;; (require 'powerline)
  ;; You can choose between different arrow shapes:
  ;; (setq powerline-arrow-shape 'arrow)   ;; the default
  ;; (setq powerline-arrow-shape 'curve)   ;; give your mode-line curves
  ;; (setq powerline-arrow-shape 'arrow14) ;; best for small fonts

  ;; You can change the mode-line color using the standard method:
  ;; (custom-set-faces
   ;; '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
   ;; '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;; Additionally, you can modify directly in `powerline.el`:
;; (setq powerline-color1 "grey22")
;; (setq powerline-color2 "grey40")
;; )

;; === milkypostman/powerline =====
(add-to-list 'load-path (concat site-lisp-dir "/milkypostman-powerline") )
(require 'powerline)
;; There are five builtin themes:
(powerline-default-theme)      ;; 有的字体（箭头）在text terminal无法正常显示
;; (powerline-center-theme)          ;; 有的字体（箭头）无法正常显示
;; (powerline-center-evil-theme)  ;; 在cygwin版本emacs不能工作
;; (powerline-vim-theme)             ;; 与自带modeline差异不大
;; (powerline-nano-theme)    ;; 最为简洁

;; == highlight-indentation && guides ==
;; (require 'highlight-indentation)
;; (set-face-background 'highlight-indentation-face "#404040")
;; (set-face-background 'highlight-indentation-current-column-face "#404040")  ;;"#c3b3b3")
;; (setq highlight-indentation-offset 4)
;; (require 'highlight-indent-guides)
;; (setq highlight-indent-guides-method 'character)
;; (setq highlight-indent-guides-auto-enabled nil) ;; to mannually set colors
;; (set-face-background 'highlight-indent-guides-odd-face "darkgray")
;; (set-face-background 'highlight-indent-guides-even-face "dimgray")
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(require 'indent-guide)
(indent-guide-global-mode)
(setq indent-guide-recursive t)
(set-face-background 'indent-guide-face "dimgray")
;; (setq indent-guide-char ":")

;; ==== popwin.el ===
(if (> emacs-major-version 22)
  (progn
	(require 'popwin)
	(popwin-mode 1)  ;; 启用popwin
  )   ;;progn 类似于c/java的花括号，将多条语句合成块，when/unless隐式progn
  (message "emacs-majar-version <= 22, ignore popwin")
)
;; == hideshow visible ==
(if (< emacs-major-version 26)
	(progn
	  (require 'hideshowvis)
	  (autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
	  (autoload 'hideshowvis-minor-mode
		"hideshowvis"
		"Will indicate regions foldable with hideshow in the fringe."
		'interactive)
	  (add-hook 'prog-mode-hook 'hideshowvis-enable)
	  (dolist (hook (list 'emacs-lisp-mode-hook 'c++-mode-hook 'python-mode-hook 'py-mode-hook))
		(add-hook hook 'hideshowvis-enable))
	  (hideshowvis-symbols)
	  (custom-set-faces
       '(hs-fringe-face ((t ( :box (:line-width 2 :color "grey75" :style released-button)))))
	'(hs-face ((t (:background "#444" :box t))))
	'(hideshowvis-hidable-face ((t (:foreground "#2f4f4f"))))
	  )
  )
  (message "emacs-majar-version >= 26, ignore hideshowvis")
)
;; == smart-tab-mode (for python-mode.el)==
;; (smart-tabs-advice py-indent-line py-indent-offset)
;; (smart-tabs-advice py-newline-and-indent py-indent-offset)
;; (smart-tabs-advice py-indent-region py-indent-offset)

(message "加载init-site-lisp.el完成")
;; init-site-lisp ENDS HERE
(provide 'init-site-lisp)
