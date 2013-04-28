(defun my-c++-mode-hook ()
  ;; namespaceの{}内はインデントしない
  (c-set-offset 'innamespace 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)

(provide 'conf-c++-mode)
