(when (require 'key-chord nil t)
  (setq key-chord-two-keys-delay 0.04)
  (key-chord-mode 1)
  (key-chord-define-global "jk" 'my-anything-locate-home))

(provide 'conf-key-chord)
