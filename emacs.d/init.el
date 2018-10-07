;; =================== .emacs.d/init.el =====================
;; self defined initialization orgnization
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq default-directory emacsd)
(add-to-list 'load-path emacsd) ;; user elisp lib dir

(defvar site-lisp-dir  (concat emacsd "/site-lisp"))
(add-to-list 'load-path site-lisp-dir)

;; (load-file custom-file)         ;;Emacs GUI customization
(require 'init-customization)     ;;Emacs GUI customization
(require 'init-ui)
(require 'init-misc)
(require 'init-coding)
(require 'init-site-lisp)
;; Must come before elpa, as it may provide package.el
(require 'init-melpa)
(when (eq system-type 'windows-nt)
  (require 'init-cygwin)
)

;; ========== self defined 自定义命令 ===========
(defun open-dot-emacs()
  (interactive)
  (find-file "~/.emacs"))
(defun open-init-el()
  (interactive)
  (find-file initel))
(defun open-emacsd()
  (interactive)
  (find-file emacsd))

;; ================ spacemacs ==================
;; (setq spacemacs-start-directory (concat emacsd "/spacemacs-0.200.10") )
;; (load-file (concat spacemacs-start-directory "init.el"))
