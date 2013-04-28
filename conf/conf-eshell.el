(when (require 'eshell nil t)
  (setq
   ;; 補完時に大文字小文字を区別しない
   eshell-cmpl-ignore-case t            
   ;; ../ を * でマッチさせない
   eshell-glob-include-dot-dot nil 
   ;; 確認なしでヒストリ保存
   eshell-ask-to-save-history (quote always)
   ;; ヒストリサイズ
   eshell-history-size 100000  
   ;; ヒストリの重複を無視
   eshell-hist-ignoredups t)

  (defun my-eshell-mode-hook ()
    (define-key eshell-mode-map (kbd "C-a") 'eshell-bol)
    (define-key eshell-mode-map (kbd "C-r") 'eshell-isearch-backward)
    (mapc '(lambda (alias)
             (add-to-list 'eshell-command-aliases-list alias))
          '(("ll" "ls -al")
            ))
    )
  (add-hook 'eshell-mode-hook 'my-eshell-mode-hook))

(provide 'conf-eshell)
