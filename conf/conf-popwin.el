(when (require 'popwin nil t)
  (setq display-buffer-function 'popwin:display-buffer)
  (setq
   popwin:popup-window-height 0.3
   anything-samewindow nil)
  (push '("*anything*" :position bottom :height 20) popwin:special-display-config)
  (push '("*my-anything-filelist+*" :position bottom :height 30) popwin:special-display-config)

  (popwin-mode 1)

  ;; (setq display-buffer-function 'popwin:display-buffer)
  ;; (setq popwin:popup-window-height 0.3)
  ;; (setq anything-samewindow nil)
  ;; (push '("\\*anything" :regexp t :height 20) popwin:special-display-config)
  ;; (push '(dired-mode :position top) popwin:special-display-config)
  ;; (push '("\\*[Vv][Cc]" :regexp t :position top) popwin:special-display-config)
  ;; (push '("\\*git-" :regexp t :position top) popwin:special-display-config)
  ;; (setq popwin:special-display-config nil)
  )

(provide 'conf-popwin)
