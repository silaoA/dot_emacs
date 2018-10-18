;; =================== emacs.d/init-cygwin.el =====================
;; initialization for cygwin
;; copyright @ silaoA<stsilaoa@gmail.com> 2016
;;          All rights reserved
(message "加载init-cygwin.el ...")

(defun setcyg-dir-p (directory)
  "Return DIRECTORY if DIRECTORY is a readable directory, nil otherwise."
  (interactive)
  (and (stringp directory)  (file-directory-p directory)  (file-readable-p directory)  directory)
)

(setq-local cygwin-root-dir (or (setcyg-dir-p "d:/cygwin") (setcyg-dir-p "d:/cygwin64") (setcyg-dir-p "d:/cygwin32") (setcyg-dir-p "c:/cygwin")) )
(setq-local  cygwin-bin (concat cygwin-root-dir "/bin") )
(setq-local cygwin-sbin (concat cygwin-root-dir "/sbin"))
(setq-local cygwin-usr (concat cygwin-root-dir "/usr") )
(setq-local cygwin-usr-bin (concat cygwin-usr "/bin") )
(setq-local cygwin-usr-sbin (concat cygwin-usr "/sbin") )
(setq-local cygwin-usr-local (concat cygwin-usr "/local") )
(setq-local cygwin-usr-local-bin (concat cygwin-usr-local "/bin") )
(setq-local cygwin-usr-local-sbin (concat cygwin-usr-local "/sbin") )
(setq-local cygwin-opt (concat cygwin-root-dir "/opt") )
(setq-local cygwin-opt-bin (concat cygwin-opt "/bin"))
(setq-local mycyghome (concat cygwin-root-dir "/home/LeiMengfei") )

(setq cygwin-path (concat
                      cygwin-bin ";"
					  cygwin-sbin ";"
					  cygwin-usr-bin ";"
					  cygwin-usr-sbin ";"
					  cygwin-usr-local-bin ";"
					  cygwin-usr-local-sbin ";"
		              cygwin-opt-bin ";")
)

(when (and (eq 'windows-nt system-type) (file-readable-p cygwin-root-dir) )
  (setq exec-path (list exec-path cygwin-bin cygwin-sbin cygwin-usr-bin cygwin-usr-sbin cygwin-usr-local-bin cygwin-usr-local-sbin cygwin-opt-bin) )
  (setenv "PATH" (concat  (getenv "PATH") cygwin-path))
)

;; ONLY for successful cygwin setup
;; Sets your shell to use cygwin's bash, if Emacs finds it's running
;; under Windows and c:\cygwin exists. Assumes that C:\cygwin\bin is
;; not already in your Windows Path (it generally should not be).
(require 'cygwin-mount)
(cygwin-mount-activate)

;; By default use the Windows HOME.
;; Otherwise, uncomment below to set a HOME
;;      (setenv "HOME" mycyghome)
(defun setenv-home (dir)
  "set dir as your home directory"
  (interactive)
  (when (and (file-readable-p dir) dir)
	(setenv "HOME" dir) )
  )

(setq explicit-shell-file-name (concat  cygwin-root-dir "/bin/bash.exe"))
(setq explicit-shell-args  '("--login" "-i")) ;; explicit-sh-args
;; Subprocesses invoked by shell, e.g "shell -c command".
(setq shell-file-name explicit-shell-file-name)
(setenv "SHELL" explicit-shell-file-name)

(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt nil t)
(defun follow-cygwin-symlink ()
  "Follow Cygwin symlinks.
Handles old-style (text file) and new-style (.lnk file) symlinks.
\(Non-Cygwin-symlink .lnk files, such as desktop shortcuts, are still
loaded as such.)"
  (save-excursion
	(goto-char 0)
	(if (looking-at
		 "L\x000\x000\x000\x001\x014\x002\x000\x000\x000\x000\x000\x0C0\x000\x000\x000\x000\x000\x000\x046\x00C")
		(progn
		  (re-search-forward
		   "\x000\\([-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`][-A-Za-z0-9_\\.\\\\\\$%@(){}~!#^'`]+\\)")
		  (find-alternate-file (match-string 1)))
	  (when (looking-at "!<symlink>")
		(re-search-forward "!<symlink>\\(.*\\)\0")
		(find-alternate-file (match-string 1)))))
  )
(add-hook 'find-file-hooks 'follow-cygwin-symlink)

  ;;;=== Use Unix-style line endings ===
;; Per Eli Z. http://debbugs.gnu.org/cgi/bugreport.cgi?bug=21780#40:
;;
;; (setq-default buffer-file-coding-system 'undecided-unix)
(setq-default buffer-file-coding-system (coding-system-change-eol-conversion
										 (default-value 'buffer-file-coding-system)  'unix) )

;;; Use /dev/null, not NUL.
(setq null-device  "/dev/null")

;;; Without this env var setting, Cygwin causes `ediff-buffers', at least, to raise an error.
;;; Making this setting here might have no effect, as the env var is checked only by the first Cygwin process
;;; invoked during your Windows session.  For best results, set this env var globally, in Windows itself.
;;; An alternative might be to use `cygpath' to change from MS Windows file names to POSIX.
(setenv "CYGWIN" "nodosfilewarning")


;; From GNU Emacs for MS Windows
(defun setup-shell ()
  "For Cygwin shell setup"
  (interactive)
  (setq comint-scroll-show-maximum-output 'this)
  (make-variable-buffer-local 'comint-completion-addsuffix))
(setq comint-completion-addsuffix t)
;; (setq comint-process-echoes t) ;; reported that this is no longer needed
(setq comint-eol-on-send t)
(setq w32-quote-process-args ?\)
	  )
;;(add-hook 'shell-mode-hook 'setup-shell)

;; From: http://www.dotfiles.com/files/6/235_.emacs
;;;###autoload
(defun set-shell-bash()
  "Enable on-the-fly switching between the bash shell and DOS."
  (interactive)
  ;; (setq binary-process-input t)
  (setq shell-file-name "bash")
  (setq shell-command-switch "-c")      ; SHOULD IT BE (setq shell-command-switch "-ic")?
  (setq explicit-shell-file-name "bash")
  (setenv "SHELL" explicit-shell-file-name)
  ;;;;;(setq explicit-sh-args '("-login" "-i")) ; Undefined?
  (setq w32-quote-process-args ?\") ;; "
  ;;;;;(setq mswindows-quote-process-args t)) ; Undefined?
  )


(defun set-shell-cmdproxy()
  "Set shell to `cmdproxy'."
  (interactive)
  (setq shell-file-name "cmdproxy")
  (setq explicit-shell-file-name "cmdproxy")
  (setenv "SHELL" explicit-shell-file-name)
  ;;;;;(setq explicit-sh-args nil)           ; Undefined?
  (setq w32-quote-process-args nil)
  )

;; =========== fakecygpty setup ===============
(require 'fakecygpty)
(fakecygpty-activate)
;;(setq fakecygpty-program "/usr/local/bin/fakecygpty.exe")
;;(setq fakecygpty-qkill-program "/usr/local/bin/qkill.exe")

(message "加载init-cygein.el完成")
;; init-cygwin ENDS HERE
(provide 'init-cygwin)
