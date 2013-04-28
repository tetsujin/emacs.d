(when (require 'wdired nil t)
  (setq wdired-allow-to-change-permissions t)
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode))

(provide 'conf-wdired)

