(when (require 'session nil t)

  ;; sessionファイル
  (setq session-save-file "~/.emacs.d/cache/.session")

  (setq session-save-print-spec '(t nil 40000))

  ;; kill-ringやミニバッファで過去に開いたファイルなどの履歴を保存する
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000)))
  ;; これがないと file-name-history に500個保存する前に max-string に達する
  (setq session-globals-max-string 100000000)
  (add-hook 'after-init-hook 'session-initialize)
  ;; 前回閉じたときの位置にカーソルを復帰
  (setq session-undo-check -1))

(provide 'conf-session)
