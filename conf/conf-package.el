(when (require 'package nil t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize))

;; misc
;; M-x package-install RET wgrep RET
;; M-x package-install RET undo-tree RET
;; M-x package-install RET yasnippet RET
;; M-x package-install RET w3m RET

(provide 'conf-package)
