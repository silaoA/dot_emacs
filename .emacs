;; =================== ~/.emacs =====================
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

;; ======== self defined initialization orgnization =========

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(put 'upcase-region 'disabled nil)
(when (eq system-type 'windows-nt)
  (defvar sync-dir "e:/BaiduSync")
)
(when (eq system-type 'gnu/linux)
 ;; (defvar sync-dir "/media/silaoa/DATA/BaiduSync") ;; for gnu linux
 (defvar sync-dir "/mnt/e/BaiduSync") ;; for WSL
 )
(when (eq system-type 'cygwin)  ;; for cygwin
  (defvar sync-dir "/e/BaiduSync")
)
(setq emacsd (concat sync-dir "/misc-back/Emacs-back/emacs.d") )
(setq custom-file (concat emacsd "/init-customization.el"))
(setq initel (concat emacsd "/init.el"))

(load-file  initel)   ;; load
