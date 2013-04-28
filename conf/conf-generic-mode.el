;; generic-x
(when (require 'generic-x nil t)
  (add-to-list 'auto-mode-alist '("\\.htaccess\\'"  . apache-conf-generic-mode))
  (add-to-list 'auto-mode-alist '("httpd\\.conf\\'" . apache-conf-generic-mode)))

(provide 'conf-generic-mode)

