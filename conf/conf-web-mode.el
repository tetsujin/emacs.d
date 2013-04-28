(when (require 'web-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("/\\(views\\|html\\|templates\\)/.*\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq
     web-mode-markup-indent-offset 2
     web-mode-css-indent-offset 2
     web-mode-code-indent-offset 2
     web-mode-indent-style 2
     web-mode-enable-block-faces t
     ;;web-mode-comment-style 2
     ))

  ;; (defadvice web-mode (before web-mode-after activate)
  ;;   (message "hoge")
  ;;   (font-lock-mode -1))

  (define-key web-mode-map (kbd "C-c C-f") 'nil)
  (define-key web-mode-map (kbd "C-c C-p") 'php-mode)
  (define-key web-mode-map (kbd "C-c C-j") 'js-mode)
  (define-key web-mode-map (kbd "C-c C-c") 'css-mode)

  (add-hook 'web-mode-hook  'my-web-mode-hook))

(provide 'conf-web-mode)

