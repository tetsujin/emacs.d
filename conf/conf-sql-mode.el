(defun my-sql-interactive-mode-hook ()
  (setq
   truncate-lines t
   sql-mysql-options '("-p")
   sql-oracle-options '("/nolog")))
(add-hook 'sql-interactive-mode-hook 'my-sql-interactive-mode-hook)

(provide 'conf-sql-mode)
