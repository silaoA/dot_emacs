;; ================ emacs.d/init-customization.el  ==================
;; init for emacs GUI customization
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved

(message "加载init-customization.el ...")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages (quote (tabbar sr-speedbar smex python-mode jedi elpy ecb)))
 '(read-file-name-completion-ignore-case t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hideshowvis-hidable-face ((t (:foreground "#2f4f4f"))))
 '(hs-face ((t (:background "#444" :box t))))
 '(hs-fringe-face ((t (:box (:line-width 2 :color "grey75" :style released-button)))))
 '(linum ((t (:background "SystemWindowFrame" :weight normal :height 0.9 :width normal)))))

(message "加载init-customization.el完成")
;; init-customization ENDS HERE
(provide 'init-customization)
