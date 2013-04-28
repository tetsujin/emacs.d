(when (require 'e2wm nil t)
  (require 'e2wm-config nil t)
  (global-set-key (kbd "M-+") 'e2wm:start-management)
  (global-set-key (kbd "M-=") 'e2wm:stop-management))

(provide 'conf-e2wm)


