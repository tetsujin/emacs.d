(when (require 'coffee-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

  (defun my-coffee-mode-hook ()
    ;; CoffeeScript uses two spaces.
    (set (make-local-variable 'tab-width) 2)

    ;; If you don't have js2-mode
    (setq coffee-js-mode 'javascript-mode)

    ;; If you don't want your compiled files to be wrapped
    (setq coffee-args-compile '("-c" "--bare"))

    ;; *Messages* spam
    (setq coffee-debug-mode t)

    ;; Emacs key binding
    (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)

    ;; Riding edge.
    (setq coffee-command "~/dev/coffee")

    ;; Compile '.coffee' files on every save
    (and (file-exists-p (buffer-file-name))
         (file-exists-p (coffee-compiled-file-name))
         (coffee-cos-mode t))

    ;; (require 'align)
    ;; (require 'regexp-opt)
    ;; (setq coffee-align-rules-list)
    ;; (setq coffee-align-region-separate)
    ;; (set (make-local-variable 'align-mode-rules-list) coffee-align-rules-list)
    ;; (set (make-local-variable 'align-region-separate) coffee-align-region-separate)
    ;; (add-to-list 'align-dq-string-modes 'coffee-mode)
    ;; (add-to-list 'align-sq-string-modes 'coffee-mode)
    )

  (add-hook 'coffee-mode-hook 'my-coffee-mode-hook))

(provide 'conf-coffee-mode)




