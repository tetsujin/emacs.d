(when (require 'sequential-command-config nil t)
  (define-key global-map (kbd "C-a") 'seq-home)
  (define-key global-map (kbd "C-e") 'seq-end)
  (when (require 'org nil t)
    (define-key org-mode-map (kbd "C-a") 'org-seq-home)
    (define-key org-mode-map (kbd "C-e") 'org-seq-end))
  (define-key esc-map "u" 'seq-upcase-backward-word)
  (define-key esc-map "c" 'seq-capitalize-backward-word)
  (define-key esc-map "l" 'seq-downcase-backward-word))

(provide 'conf-sequential-command)