(when (require 'color-moccur nil t)

  (define-key global-map (kbd "M-o") 'occur-by-moccur)

  ;; スペース区切りでAND検索
  (setq moccur-split-word t)

  ;; ディレクトリ検索の時に除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")

  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (setq moccur-use-migemo t)))

(provide 'conf-color-moccur)
