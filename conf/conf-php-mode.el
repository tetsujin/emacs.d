(when (require 'php-mode nil t)

  ;; Geben
  (autoload 'geben "geben" "DBGp protocol front-end" t)
  
  ;; Symfony
  (require 'symfony nil t)

  (defun php-convert-to-hash-key-region (beg end)
    "Convert selected region as hash key syntax for PHP"
    (interactive "r")
    (save-excursion
      (save-restriction
        (narrow-to-region beg end)
        (goto-char beg)
        (while (re-search-forward "^\\s-*\\(.+?\\)\\s-*$" nil t)
          (replace-match "'\\1' => ," nil nil))))
    (indent-region beg end))

  (defun php-eval (beg end)
    "Run selected region as PHP code"
    (interactive "r")
    (let ((code (concat "<?php " (buffer-substring beg end))))
      (with-temp-buffer
        (insert code)
        (shell-command-on-region (point-min) (point-max) "php")
        )))

  ;; php-mode-hook
  (defun my-php-mode-hook ()
    
    ;; php-completion
    (when (require 'php-completion nil t)
      (php-completion-mode t))

    (setq
     tab-width 4
     c-basic-offset 4
     indent-tabs-mode nil
     ;; php-mode-force-pear t
     )
    
    (c-set-offset 'case-label '+)
    ;; (c-set-offset 'arglist-intro '+)
    ;; (c-set-offset 'arglist-close 0)
    (c-set-offset 'comment-intro 0)
    ;; (c-set-offset 'arglist-cont-nonempty 'c-lineup-arglist-intro-after-paren)
    ;; (c-set-offset 'topmost-intro-cont 'c-lineup-cascaded-calls)
    (set (make-local-variable 'comment-start) "//")
    (set (make-local-variable 'comment-end) "")

    ;; keymap
    (define-key php-mode-map "\M-\C-p" 'php-eval)
    ;;(define-key php-mode-map (kbd "C-;") 'phpcmp-complete)
    (define-key php-mode-map "\M-[;" 'phpcmp-complete) ; for my putty setting
    (define-key php-mode-map (kbd "C-c C-f") 'nil)

    ;; phpdoc
    (when (require 'phpdoc nil t)
      (eldoc-mode t))

    ;; php-align
    (when (require 'php-align nil t)
      (php-align-setup))

    ;; smartchr
    ;; (when (require 'smartchr nil t)
    ;;   (define-key php-mode-map (kbd "=") (smartchr-if-face '("=" " = "  " == " " === ") '(nil))))
    
    )
  (add-hook 'php-mode-hook 'my-php-mode-hook)

  (define-key php-mode-map (kbd "C-c C-b") 'web-mode)
  
  (add-to-list 'auto-mode-alist  '("\\.\\(php\\|inc\\|\\ctp\\)\\'" . php-mode)))
  


(provide 'conf-php-mode)
