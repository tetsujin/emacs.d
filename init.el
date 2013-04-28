(setq debug-on-error t)

;; exec-path
(setq exec-path
      (list (expand-file-name "~/local/bin")
             "/bin"
             "/sbin"
             "/opt/local/bin"
             "/usr/local/bin"
             "/usr/local/sbin"
             "/usr/bin"
             "/usr/sbin"
             "/usr/X11/bin"
             "/usr/local/git/bin"
             "/Applications/Emacs.app/Contents/MacOS/libexec"
             "/Applications/Emacs.app/Contents/MacOS/bin"
             "/usr/X11R6/bin"))
(setenv "PATH" (substring (shell-command-to-string "echo $PATH") 0 -1))

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp" "conf")

(require 'conf-package)
(require 'conf-auto-install)

(require 'conf-color-moccur)
(require 'conf-moccur-edit)
(require 'conf-wgrep)

(require 'conf-migemo)
(require 'conf-eldoc)

;; (require 'conf-redo+)
(require 'conf-undo-tree)
(require 'conf-undohist)
(require 'conf-point-undo)
(require 'conf-session)

(require 'conf-smartchr)
(require 'conf-accelerate)

;; (require 'conf-iswitchb)
(require 'conf-wdired)

(require 'conf-eshell)
(require 'conf-w3m)

(require 'conf-generic-mode)
(require 'conf-markdown-mode)
(require 'conf-cc-mode)
(require 'conf-c++-mode)
(require 'conf-coffee-mode)
(require 'conf-cperl-mode)
(require 'conf-js-mode)
(require 'conf-css-mode)
(require 'conf-scss-mode)
(require 'conf-php-mode)
(require 'conf-web-mode)
(require 'conf-sql-mode)

(require 'conf-yasnippet)
(require 'conf-anything)
(require 'conf-auto-complete)

(require 'conf-popwin)
(require 'conf-e2wm)

(require 'conf-dmacro)
(require 'conf-cua-mode)
(require 'conf-key-chord)
(require 'conf-sequential-command)

(require 'conf-color-theme)
(require 'conf-dircolors)
(require 'conf-whitespace)
;; (require 'conf-jaspace)

(require 'conf-function)

;;; Language

;; 日本語設定
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
;; Mac OS X
(when (eq system-type 'darwin)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq local-coding-sytem 'utf-8-hfs))
;; Windows
(when (eq system-type 'w32)
  (require 'ucs-normalize)
  (set-file-name-coding-system 'cp932)
  (setq local-coding-sytem 'cp932))


;;; 

;; 初期位置
(cd "~/")
;; 起動時のメッセージを非表示
(setq inhibit-startup-message t)
;; scratchのメッセージを非表示
(setq initial-scratch-message nil)

;;; Visual

;; カラム番号表示
(column-number-mode t)
;; 行番号表示
(line-number-mode t)
;; ファイルサイズ表示
(size-indication-mode t)
;; 時計表示
;; (setq display-time-day-and-date t) ; 曜日・月・日
;; (setq display-time-24hr-format t) ; 24時表示
;; (display-time-mode nil)
;; バッテリー情報表示
(display-battery-mode t)
;; bellをならさない
(setq ring-bell-function 'ignore)
;; vbellをならさない
(setq visible-bell nil)

;; メニューバー非表示
(menu-bar-mode -1)
(when window-system
  ;; ツールバー非表示
  (tool-bar-mode -1)
  ;; スクロールバー非表示
  (set-scroll-bar-mode nil)
  ;; タイトルバーにファイルのフルパス表示
  (setq frame-title-format "%f"))


;; 対応する括弧を色付け
(show-paren-mode t)
(setq show-paren-style 'parenthesis)	; 対応する括弧を色付け
;; (setq show-paren-style 'expression)  ; 括弧内を色付けする

;; カーソルを点滅させる
(blink-cursor-mode t)

;; リージョン内の行数と文字数をモードラインに表示(範囲選択中のみ)
;; http://d.hatena.ne.jp/sonota88/20110224/1298557375
(defun count-lines-and-chars ()
  (if mark-active
      (format "%d lines,%d chars "
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
      ;;(count-lines-region (region-beginning) (region-end)) ;; これだとエコーエリアがチラつく
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

(when (< emacs-major-version 24)
  ;; ミニバッッファ補完 foo/bar/baz を f/b/b などで展開してくれる
  (partial-completion-mode t)
  ;; Shift + 矢印キーでマーク選択
  (pc-selection-mode))

;; マークを色付けする
(setq transient-mark-mode t)

;; リージョン選択時にdeleteで削除できるようにする
(delete-selection-mode t)

;; yes or no を y or n で入力できるようにする
(fset 'yes-or-no-p 'y-or-n-p)

;; shebang行があるファイル保存時に実行権限を付与する
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; readonlyでもキルリングできるようにする
(setq kill-read-only-ok t)
;; 行頭でC-kすると行全体を削除
;; (setq kill-whole-line t)

;; grepコマンドのひな形
(setq grep-find-command "find . -type f -path '.svn' -or -path 'CVS' -prune -o -print0 | xargs -0 grep --binary-files=without-match -nH -e ")
(defadvice rgrep (before my-rgrep activate)
  "*grep*バッファがあれば、それを削除するか確認する"
  (when (get-buffer "*grep*")
    (when (y-or-n-p "現在の *grep* を削除しますか")
      (kill-buffer (get-buffer "*grep*")))))


;; 長い行を折り返し表示しない
(setq default-truncate-lines t)
(setq truncate-partial-width-windows nil)

;; 圧縮ファイルを開けるようにする
(auto-compression-mode t)
;; 最終行に改行を自動挿入する
(setq mode-require-final-newline t)

;; customizeの保存先ファイル
(setq custom-file "~/.emacs.d/etc/customize.el")

;; Emacs終了時に確認する
(setq confirm-kill-emacs 'y-or-n-p)

;; 自動改行設定
(setq-default auto-fill-mode nil)
(setq-default fill-column 300)

;; 行末のスペースやタブに色づけして警告する。
(setq show-trailing-whitespace t)

;; バッファの末尾をわかりやすくする
;; (setq-default indicate-empty-lines t)
;; (setq-default indicate-buffer-boundaries 'right)
(setq-default indicate-unused-lines nil)
(setq-default indicate-empty-lines nil)
(setq-default indicate-buffer-boundaries nil)

;; 変更点に色付け
;; (global-highlight-changes-mode nil)
;; (setq highlight-changes-visibility-initial-state t)

;; 現在行に色付け
;; (global-hl-line-mode)
;; (hl-line-mode 1)


;; Font
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
(setq font-lock-maximum-decoration t)

;; Backup & Autosave
(setq backup-inhibited nil)
(setq delete-auto-save-files t)
;; (setq make-backup-files nil)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

;; Scroll
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)
(setq scroll-preserve-screen-position t) ; C-vなどでカーソルの垂直位置を維持

;; X
;; (xterm-mouse-mode 1)
;; (mwheel-install)
;; (setq mouse-wheel-follow-mouse t)

;; 下記のコマンド実行時にy/n確認されないようにする
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; TABの表示幅
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; uniquify
(when (require 'uniquify nil t)
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; windmove
(windmove-default-keybindings 'meta)
(define-key global-map (kbd "M-3") 'split-window-horizontally)
(define-key global-map (kbd "M-2") 'split-window-vertically)
(define-key global-map (kbd "M-1") 'delete-other-windows)
(define-key global-map (kbd "M-0") 'delete-window)

;;; winner-mode
(when (fboundp 'winner-mode)
  (winner-mode t))

(keyboard-translate ?\C-h ?\C-?)
;; (define-key global-map (kbd "C-h") 'delete-backward-char)
(define-key global-map (kbd "C-m") 'newline-and-indent)
;; バッファの先頭へ
(define-key global-map [home]   'beginning-of-buffer)
;; バッファの末尾へ
(define-key global-map [end]    'end-of-buffer)
(define-key global-map [select] 'end-of-buffer)         ; putty用
;; アライメント
(define-key global-map (kbd "C-c a") 'align-current) ; 現在のブロック内をalignする
(define-key global-map (kbd "C-c r") 'align-regexp)  ; リージョンを正規表現でalignする
;; C-wでbackward-kill-wordする。リージョン選択中はkill-regionする。
(defun kill-region-or-backward-kill-word (&optional arg)
  "Kill a region or a word backward."
  (interactive)
  (if mark-active
      (kill-region (mark) (point))
    (backward-kill-word (or arg 1))))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)
;; C-x oの逆方向でウィンドウを切り替える
(define-key global-map "\C-xp" (lambda (arg) (interactive "p") (other-window (- arg))))
;; リージョン内をインデントする
(define-key global-map "\C-c\\"  'indent-region)
;; ミニバッファ内で前の単語を削除する(ディレクトリ階層を上がるときに便利)
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)
;; (define-key isearch-mode-map "\C-h" 'isearch-delete-char)
;; リージョンの文字列をcamerize / decamelizeをtoggleする
(define-key global-map "\C-co" 'ik:camerize<->decamelize-on-region)
;; 行の折り返し設定のtoggle
(define-key global-map (kbd "C-c l") 'toggle-truncate-lines)

;; デフォルトで縦分割にする
(setq ediff-split-window-function 'split-window-horizontally)

;; 操作ウィンドウを新規にする
;;(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; デフォルトでreadonlyにする
;;(setq diff-default-read-only t)

;; Cocoa Emacs
(when (eq window-system 'ns)

  ;; ;; Emacs と Mac のクリップボード共有
  ;; ;; from http://hakurei-shain.blogspot.com/2010/05/mac.html
  ;; (defun copy-from-osx ()
  ;;   (shell-command-to-string "pbpaste"))

  ;; (defun paste-to-osx (text &optional push)
  ;;   (let ((process-connection-type nil))
  ;;     (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
  ;;       (process-send-string proc text)
  ;;       (process-send-eof proc))))
  ;; (setq interprogram-cut-function 'paste-to-osx)
  ;; (setq interprogram-paste-function 'copy-from-osx)

   ;; Command, Optionを入れ替え
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))

  ;; D&Dなどで新しいwindowを開かないようにする
  (setq ns-pop-up-frames nil)

  ;; モードラインにIMステータス表示
  (setq default-input-method "MacOSX")

  ;; IMの状態で色を分ける
  (mac-set-input-method-parameter "com.apple.inputmethod.Kotoeri.Roman" 'cursor-color "yellow")     ; ことえり ローマ字
  (mac-set-input-method-parameter "com.apple.inputmethod.Kotoeri.Japanese" 'cursor-color "magenta") ; ことえり 日本語
  (mac-set-input-method-parameter "com.google.inputmethod.Japanese.Roman" 'cursor-color "yellow")   ; Google ローマ字
  (mac-set-input-method-parameter "com.google.inputmethod.Japanese.base" 'cursor-color "magenta")   ; Google 日本語

  ;; minibufferに移動するとIMをoffにする
  (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)

  ;; システムへ修飾キーを渡さない
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  ;; (setq mac-pass-option-to-system nil)

  ;; JISキーボードで、円マークを押すとバックシュラッシュ、Option+円マークで
  (mac-translate-from-yen-to-backslash)
  ;; USキーボードでOption-\で円マーク
  (define-key global-map (kbd "s-\\") '(lambda () (interactive) (insert "¥")))

  ;; ドラッグドロップで新しくファイルを開く
  (define-key global-map [ns-drag-file] 'ns-find-file)

  ;; 起動時設定
  (setq initial-frame-alist
        (append (list
                 ;; ウィンドウサイズ
                 '(width . 209)
                 '(height . 57)
                 ;;表示位置
                 '(top . 0)
                 '(left . 0)
                 ;; C-x 5 2等で新規フレームを開いたときに、色がデフォルトになる問題対応
                 '(foreground-color . "cornsilk")
                 '(background-color . "black")
                 '(cursor-colr      . "yellow")
                 ;; 透過設定 (アクティブ時, 非アクティブ時)
                 '(alpha . (85 50))
                 ) initial-frame-alist))
  (setq default-frame-alist initial-frame-alist)

  (let* ((size 12) ; ASCIIフォントのサイズ [9/10/12/14/15/17/19/20/...]
         (asciifont "Menlo") ; ASCIIフォント
         ;; (jpfont "TakaoExGothic")             ; 日本語フォント
         (jpfont "Hiragino Kaku Gothic ProN") ; 日本語フォント
         (h (* size 10))
         (fontspec (font-spec :family asciifont))
         (jp-fontspec (font-spec :family jpfont)))
    (set-face-attribute 'default nil :family asciifont :height h)
    ;; http://sakito.jp/moin/moin.cgi/EmacsFont を参考にして必要そうなものを追加
    (set-fontset-font nil 'jisx0201                 jp-fontspec)
    (set-fontset-font nil 'latin-jisx0201           jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0208        jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0208-1978   jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0212        jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-1      jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-2      jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-a      jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
    (set-fontset-font nil 'katakana-sjis            jp-fontspec)
    (set-fontset-font nil 'cp932-2-byte             jp-fontspec)
    (set-fontset-font nil 'cp932                    jp-fontspec)
    (set-fontset-font nil '(#x3040 . #x309f)        jp-fontspec) ; ひらがな
    (set-fontset-font nil '(#x30a0 . #x30ff)        jp-fontspec) ; カタカナ
    (set-fontset-font nil '(#xff00 . #xffef)        jp-fontspec) ; 半角・全角系
    (set-fontset-font nil '(#x0370 . #x03FF)        fontspec)    ; ギリシャ文字
    )

  ;; フォントサイズの比を設定
  (setq face-font-rescale-alist
        '(("^-apple-hiragino.*" . 1.2)
          (".*osaka-bold.*" . 1.2)
          (".*osaka-medium.*" . 1.2)
          (".*courier-bold-.*-mac-roman" . 1.0)
          (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
          (".*monaco-bold-.*-mac-roman" . 0.9)
          ("-cdac$" . 1.3)))
  )


;; emacsclient
;; http://norainu.net/mt/archives/2006/08/emacsclient_1.html
(add-hook 'after-init-hook 'server-start)
(shell-command "echo $WINDOW >~/.emacs.d/cache/emacs-server-window")
(add-hook 'emacs-kill-hook
          (lambda ()
            (shell-command
             "rm ~/.emacs.d/cache/emacs-server-window")))


;; (setq el-get-dir "~/.emacs.d/lisp/el-get/")
;; (unless (require 'el-get nil t)
;;   (url-retrieve
;;    "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
;;    (lambda (s)
;;      (let (el-get-master-branch)
;;        (end-of-buffer)
;;        (eval-print-last-sexp)))))
;; (setq el-get-sources
;;       '(
;;         (:name init-loader
;;                :type http
;;                :url "http://svn.coderepos.org/share/lang/elisp/init-loader/init-loader.el")
;; 	))
;; ;; http://d.hatena.ne.jp/kitokitoki/20101205/p1
;; (defun init-loader-re-load (re dir &optional sort)
;;   (let ((load-path (cons dir load-path)))
;;     (dolist (el (init-loader--re-load-files re dir sort))
;;       (condition-case e
;;           (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
;;             (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
;;         (error
;;          ;; (init-loader-error-log (error-message-string e)) ；削除
;;          (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
;;          )))))

;; (require 'init-loader)
;; (init-loader-load "~/.emacs.d/site-start.d")


