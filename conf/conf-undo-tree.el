(when (require 'undo-tree nil t)
  (global-undo-tree-mode)
  (define-key global-map (kbd "M-/") 'undo-tree-redo))

(provide 'conf-undo-tree)
