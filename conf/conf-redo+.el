(when (require 'redo+ nil t)
  (setq
   undo-no-redo t
   ;; 緩い限界
   undo-limit 100000        
   ;; 厳密な限界
   undo-strong-limit 200000)
  
  (define-key global-map (kbd "M-C-/") 'redo))

(provide 'conf-redo+)


