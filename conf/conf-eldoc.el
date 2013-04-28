;; Use Emacs23's eldoc
(require 'eldoc nil t)
;; (auto-install-from-emacswiki "eldoc-extension.el")
(when (require 'eldoc-extension nil t)
  (setq eldoc-idle-delay 0.20)
  (setq eldoc-echo-area-use-multiline-p t)
  (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
  (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode))

(provide 'conf-eldoc)
