(when (require 'jaspace nil t)
  (setq
   ;; 全角スペース表示文字
   jaspace-alternate-jaspace-string "□"
   ;; TABの表示
   jaspace-highlight-tabs t)
   ;; TABの色
   (set-face-background 'jaspace-highlight-tab-face "grey15") 
   ;; on-offで行末の空白表示を切り替える
   (add-hook 'jaspace-mode-hook '(lambda () (setq show-trailing-whitespace t)))
   (add-hook 'jaspace-mode-off-hook '(lambda () (setq show-trailing-whitespace nil)))
   ;; デフォルトonになって欲しいモードをここに追加
   (mapc '(lambda (x) (add-to-list 'jaspace-modes x))
         '(sql-mode
           php-mode
           web-mode
           html-mode
           js-mode
           js2-mode
           coffee-mode
           ))
   (add-hook 'mmm-mode-hook 'jaspace-mmm-mode-hook))

(provide 'conf-jaspace)
