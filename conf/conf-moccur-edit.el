(when (require 'moccur-edit nil t)
  ;; moccur-edit-finish-editと同時にファイルを保存する
  (defadvice moccur-edit-change-file
    (after save-after-moccur-edit-buffer activate)
    (save-buffer)))

(provide 'conf-moccur-edit)
