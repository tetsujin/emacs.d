;; 参考: http://cloverrose.hateblo.jp/entry/2013/04/12/145825
(when (require 'auto-complete-config nil t)

  ;; 辞書のディレクトリ
  (add-to-list 'ac-dictionary-directories
               "~/.emacs.d/elisp/auto-complete/dict")

  (setq
   ;; 補完推測機能のデータ保存場所
   ac-comphist-file "~/.emacs.d/cache/ac-comphist.dat"
   ;; n文字以上の単語の時に補完を開始
   ac-auto-start 2
   ;; n秒後に補完開始
   ac-delay 0.05
   ;; 曖昧マッチ有効
   ac-use-fuzzy t
   ;; 補完推測機能有効
   ac-use-comphist t
   ;; n秒後に補完メニューを表示
   ac-auto-show-menu 0.05
   ;; n秒後にクイックヘルプを表示
   ac-quick-help-delay 0.5
   ;; 補完対象に大文字が含まれる場合は区別する
   ac-ignore-case 'smart)

  (when (require 'ac-company nil t)
    ;; ac-company で company-xcode を有効にする
    (ac-company-define-source ac-source-company-xcode company-xcode)
    ;; objc-mode で補完候補を設定
    (setq ac-modes (append ac-modes '(objc-mode)))

    (add-hook 'objc-mode-hook 'my-objc-mode-ac-hook)
    (defun my-objc-mode-ac-hook ()
      ;; XCode を利用した補完を有効にする
      (push 'ac-source-company-xcode ac-sources)
      ;; C++ のキーワード補完をする Objective-C++ を利用する人だけ設定してください
      ;;(push 'ac-source-c++-keywords ac-sources)
    ))

  (require 'auto-complete-etags nil t)
  (defun ac-config-default ()
    (setq-default ac-sources '(ac-source-yasnippet
                               ac-source-abbrev
                               ac-source-dictionary
                               ac-source-words-in-same-mode-buffers
                               ac-source-etags
                               )))
  (set-face-foreground 'ac-etags-candidate-face "blue")
  (set-face-background 'ac-etags-selection-face "blue")
  (ac-config-default)

  ;; 適用するメジャーモードを足す
  (add-to-list 'ac-modes 'scss-mode)
  (add-to-list 'ac-modes 'web-mode)
  (add-to-list 'ac-modes 'coffee-mode)
  (add-to-list 'ac-modes 'php-mode)
  (add-to-list 'ac-modes 'yaml-mode)
  (add-to-list 'ac-modes 'html-mode)
  (add-to-list 'ac-modes 'js2-mode)
  (add-to-list 'ac-modes 'js-mode)
  (add-to-list 'ac-modes 'nxhtml-mode)

  (defun ac-php-mode-setup ()
    (when (require 'php-completion nil t)
      (add-to-list 'ac-sources 'ac-source-php-completion-patial))
    (setq-default ac-sources ac-sources))
  (defun ac-scss-mode-setup ()
    (setq-default ac-sources (append '(ac-source-css-property) ac-sources)))
  (defun ac-web-mode-setup ()
    (setq-default ac-sources ac-sources))
  (defun ac-coffee-mode-setup ()
    (setq-default ac-sources ac-sources))
  (add-hook 'php-mode-hook 'ac-php-mode-setup)
  (add-hook 'scss-mode-hook 'ac-scss-mode-setup)
  (add-hook 'web-mode-hook 'ac-web-mode-setup)
  (add-hook 'coffee-mode-hook 'ac-coffee-mode-setup)

  ;; yasnippetのbindingを指定するとエラーが出るので回避する方法。
  ;; http://fukuyama.co/yasnippet
  (setf (symbol-function 'yas-active-keys)
        (lambda ()
          (remove-duplicates (mapcan #'yas--table-all-keys (yas--get-snippet-tables)))))


  (global-auto-complete-mode t)
  
  ;; C-n / C-p で選択
  (setq ac-use-menu-map t)
  (define-key global-map  (kbd "C-o") 'ac-start)
  (define-key ac-completing-map (kbd "M-/") 'ac-stop)

  (when (require 'ac-anything2 nil t)
    (define-key ac-completing-map (kbd "C-o") 'ac-anything2))

  ;; (define-key ac-menu-map (kbd "C-n") 'ac-next)
  ;; (define-key ac-menu-map (kbd "C-p") 'ac-previous)
  
  ;; auto-complete の候補に日本語を含む単語が含まれないようにする
  ;; http://d.hatena.ne.jp/IMAKADO/20090813/1250130343
  (defadvice ac-word-candidates (after remove-word-contain-japanese activate)
    (let ((contain-japanese (lambda (s) (string-match (rx (category japanese)) s))))
      (setq ad-return-value
            (remove-if contain-japanese ad-return-value)))))

(provide 'conf-auto-complete)
