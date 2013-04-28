(when (require 'eclim-load nil t)
  (require 'eclim-php)
  (require 'ac-emacs-eclim)
  (require 'anything-eclim)
  (require 'flymake-eclim)

  (defun ac-emacs-eclim-complete ()
    (interactive)
    (let ((ac-auto-start t))
      (auto-complete '(ac-source-emacs-eclim))))

  (defun my-java-mode-eclim-hook ()
    (define-key java-mode-map (kbd "C-;") 'ac-emacs-eclim-complete))
  (add-hook 'java-mode-hook 'my-java-mode-eclim-hook)
  (defun my-php-mode-eclim-hook ()
    (define-key php-mode-map (kbd "C-;") 'ac-emacs-eclim-complete))
  (add-hook 'php-mode-hook 'my-php-mode-eclim-hook)

  (setq eclim-auto-save t)
  (setq acee-use-yasnippet-p t)
  (global-eclim-mode))

(provide 'conf-eclim)
