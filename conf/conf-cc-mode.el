(when (require 'c-eldoc nil t)
  (setq c-eldoc-cpp-command "/usr/bin/cpp "))

(defun my-c-mode-common-hook ()
  ;; 連続する空白を一括削除
  ;;(c-toggle-hungry-state 1)

  ;; 基本スタイル
  ;;(setq c-default-style "k&r")
  (c-set-style "cc-mode")

  ;; 基本オフセット
  (setq c-basic-offset 4)

  ;; 演算式が複数行にまたがるときのオフセット
  (c-set-offset 'statement-cont 'c-lineup-math)

  ;; 引数listの引数の1行目
  (c-set-offset 'arglist-intro '+)
  ;; 引数listの閉じ括弧
  (c-set-offset 'arglist-close 0)
  ;; 引数listの開き括弧の行に引数がある場合の引数の2行目以降
  (c-set-offset 'arglist-cont-nonempty 0)

  ;; comment 1行目の開始位置
  (c-set-offset 'comment-intro 0)

  ;; コンパイルコマンドの設定
  (setq compile-command "make")

  ;; キー設定
  (define-key c-mode-base-map (kbd "C-c c") 'smart-compile)
  (define-key c-mode-base-map (kbd "C-c c") 'compile)
  (define-key c-mode-base-map (kbd "C-c n") 'next-error)
  (define-key c-mode-base-map (kbd "C-c p") 'previous-error))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-c-mode-hook ()
  ;; 指定したmajor-modeからhookされた場合だけ呼ぶ (php-modeなどでもc-mode-hookが呼ばれるが実行したくない)
  (when (memq major-mode '(c-mode cc-mode))
      ;; c-eldoc
    (set (make-local-variable 'eldoc-idle-delay) 0.20)
    (c-turn-on-eldoc-mode)))
(add-hook 'c-mode-hook 'my-c-mode-hook)

;; ffapでの探索path
(setq ffap-c-path '("/usr/include" "/usr/local/include"))
;; 新規ファイルの場合には確認
(setq ffap-newfile-prompt t)
;; ffap-kpathsea-expand-path で展開するパスの深さ
(setq ffap-kpathsea-depth 5)

;; コンパイルバッファの出力を追従するようにスクロールする
(setq compilation-scroll-output t)
;; コンパイルバッファの高さ
(setq compilation-window-height 20)

;; gdb
(setq
 gdb-many-windows t
 gdb-use-separate-io-buffer t)

(provide 'conf-cc-mode)
