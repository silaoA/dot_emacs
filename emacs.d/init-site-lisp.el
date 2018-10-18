;; ================= emacs.d/init-site-lisp.el ===================
;; initialization for site-lisp package
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-site-lisp.el ...")

;; == unicad ==
(require 'unicad)

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

;; == smart-tab-mode (for python-mode.el)==
;; (smart-tabs-advice py-indent-line py-indent-offset)
;; (smart-tabs-advice py-newline-and-indent py-indent-offset)
;; (smart-tabs-advice py-indent-region py-indent-offset)

(message "加载init-site-lisp.el完成")
;; init-site-lisp ENDS HERE
(provide 'init-site-lisp)
