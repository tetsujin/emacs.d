(when (require 'yasnippet nil t)

  (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets/base")
  
  ;; 参考: http://fukuyama.co/yasnippet
  (custom-set-variables
   '(yas-trigger-key "C-;"))

  (yas-global-mode 1))

(provide 'conf-yasnippet)
