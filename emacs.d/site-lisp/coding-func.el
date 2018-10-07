;; customed functions for coding

 ;; ============= smart comment-or-uncomment-region
(defun smart-comment-or-uncomment-region (beg end &optional arg)  
  (interactive (if (use-region-p)  
                   (list (region-beginning) (region-end) nil)  
                 (list (line-beginning-position)  
                       (line-beginning-position 2))))  
  (comment-or-uncomment-region beg end arg)  
)  
;; configuration for smart comment-or-uncomment-region in dot emacs
;; (require 'coding-func)
;; (global-set-key (kbd "C-c C-q") 'smart-comment-or-uncomment-region)

;; =========  Org-style folding for a `.emacs' (and much more) =========  
(defun my-outline-regexp ()
  "Calculate the outline regexp for the current mode."
  (let ((comment-starter (replace-regexp-in-string
						  "[[:space:]]+" "" comment-start)))
	(when (string= comment-start ";")
	  (setq comment-starter ";;"))
 ;; (concat "^" comment-starter "\\*+")))
	(concat "^" comment-starter "[*]+ ")
  )
)

(defun my-outline-minor-mode-hook ()
  (interactive)
  (setq outline-regexp (my-outline-regexp))
  (let* ((org-fontify-whole-heading-line "")
		(heading-1-regexp
		(concat (substring outline-regexp 0 -1)
				 "\\{1\\} \\(.*" org-fontify-whole-heading-line "\\)") )
		(heading-2-regexp
		 (concat (substring outline-regexp 0 -1)
				 "\\{2\\} \\(.*" org-fontify-whole-heading-line "\\)") )
		(heading-3-regexp
		 (concat (substring outline-regexp 0 -1)
				 "\\{3\\} \\(.*" org-fontify-whole-heading-line "\\)") )
		(heading-4-regexp
		 (concat (substring outline-regexp 0 -1)
				 "\\{4,\\} \\(.*" org-fontify-whole-heading-line "\\)")) 
		)
	(font-lock-add-keywords
	 nil
	 `((,heading-1-regexp 1 'org-level-1 t)
	   (,heading-2-regexp 1 'org-level-2 t)
	   (,heading-3-regexp 1 'org-level-3 t)
	   (,heading-4-regexp 1 'org-level-4 t)))
	)
) 

;; configuration for Org-style folding in dot emacs
;; (require 'coding-func)	   
;; (add-hook 'outline-minor-mode-hook
;; 		  'my-outline-minor-mode-hook) 

;;  ===  Org-style folding  code ENDS here

;; === unindent block ===
(defun un-indent-by-removing-4-spaces ()
  "remove 4 spaces from beginning of of line"
  (interactive)
  (save-excursion
    (save-match-data
      (beginning-of-line)
      ;; get rid of tabs at beginning of line
      (when (looking-at "^\\s-+")
        (untabify (match-beginning 0) (match-end 0)))
      (when (looking-at "^    ")
        (replace-match "")))))
;; configuration  for unindent block
;; (global-set-key (kbd "<S-tab>") 'un-indent-by-removing-4-spaces)

;; == yank indent ==
(defun yank-and-indent ()
  "Yank and then indent the newly formed region according to mode."
  (interactive)
  (yank)
  (call-interactively 'indent-region))

(provide 'coding-func)
;; == coding-func.el ends here!
