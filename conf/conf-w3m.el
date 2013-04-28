(when (require 'w3m nil t)
  (setq
   w3m-command "/usr/local/bin/w3m"
   ;; Cookieを使う
   w3m-use-cookies t))

(provide 'conf-w3m)
