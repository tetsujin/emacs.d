(when (require 'iswitchb nil t)
  ;; (iswitchb-mode 1)
  ;; 除外するバッファ
  ;;   (setq iswitchb-buffer-ignore
  ;;         '(
  ;;           "*Messages*"
  ;;           "*Compile-Log*"
  ;;           "*Completions*"
  ;;           ))
  (add-hook 'iswitchb-define-mode-map-hook
            '(lambda ()
               (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
               (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)
               )))

(provide 'conf-iswitchb)


