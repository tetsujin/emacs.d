(when (executable-find "cmigemo")
  
  (when (require 'migemo nil t) 
    (setq migemo-command "cmigemo")
    (setq migemo-options '("-q" "--emacs"))

    ;; Set your installed path
    (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")

    (setq migemo-user-dictionary nil)
    (setq migemo-regex-dictionary nil)
    (setq migemo-coding-system 'utf-8-unix)
    (load-library "migemo")
    (migemo-init))

  ;; ;; base
  ;; ;;(setenv "LD_LIBRARY_PATH" (expand-file-name "~/local/lib"))
  ;; (setq migemo-command "cmigemo")
  ;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  ;; (setq migemo-dictionary (expand-file-name "/usr/local/share/migemo/utf-8/migemo-dict")) ; PATH of migemo-dict
  ;; (setq migemo-user-dictionary nil)
  ;; (setq migemo-regex-dictionary nil)
  ;; ;; use cache
  ;; (setq migemo-use-pattern-alist t)
  ;; (setq migemo-use-frequent-pattern-alist t)
  ;; (setq migemo-pattern-alist-length 1024)
  ;; ;; charset encoding
  ;; (setq migemo-coding-system 'utf-8-unix)
  ;; (load-library "migemo")

  ;; ;; initialization
  ;; ;;(migemo-init)
  )

(provide 'conf-migemo)
