(autoload 'js-mode "js" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

;; http://d.hatena.ne.jp/Rion778/20100925/1285419192
;; C-c C-jでjs-consoleを起動
;; C-c rで選択範囲を実行
(autoload 'js-console "js-console" nil t)
(defun js-console-execute-region (start end)
  "Execute region"
  (interactive "r")
  (let ((buf-name (buffer-name (current-buffer))))
    (copy-region-as-kill start end)
    (switch-to-buffer-other-window "*js*")
    (js-console-exec-input (car kill-ring))
    (switch-to-buffer-other-window buf-name)))
(defun run-js-console-and-split-window ()
  "Run js-console and split window horizontally."
  (interactive)
  (split-window-horizontally)
  (js-console)
  (other-window 1)
  )

(defun my-js-mode-hook ()
  (setq indent-tabs-mode nil)
  ;; (moz-minor-mode 1) ;; 要moz.el
  (local-set-key "\C-c\C-j" 'run-js-console-and-split-window)
  ;;(local-set-key "\C-c\C-r" 'js-console-execute-region)
  (define-key js-mode-map (kbd "C-c C-b") 'web-mode)
  )
(add-hook 'js-mode-hook 'my-js-mode-hook)

;; js2-mode https://github.com/mooz/js2-mode
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;; (add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

;; (setq js2-consistent-level-indent-inner-bracket-p t)
;; (setq js2-pretty-multiline-decl-indentation-p nil)
;; (setq js2-rebind-eol-bol-keys nil)
;; (setq js2-strict-missing-semi-warning nil)

(provide 'conf-js-mode)
