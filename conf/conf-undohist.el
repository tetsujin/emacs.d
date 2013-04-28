(when (require 'undohist nil t)

  (setq
   ;; 履歴保存先ディレクトリ
   undohist-directory "~/.emacs.d/cache/undohist")
  
  (undohist-initialize))

(provide 'conf-undohist)
