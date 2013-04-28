(when (require 'auto-install nil t)
  ;; インストール先ディレクトリの設定
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelispの名前を取得する
  ;; (auto-install-update-emacswiki-package-name t)
  ;; install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))


;; anything
;; (auto-install-batch "anything")
;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
;; (auto-install-from-emacswiki "anything-yaetags.el")
;; (auto-install-from-emacswiki "anything-dabbrev-expand.el")
;; (auto-install-from-url "https://raw.github.com/imakado/anything-project/master/anything-project.el")

;; auto-complete
;; auto-installはやめてgit submodule管理にした
;; ;;(auto-install-batch "auto-complete development version")
;;
;; % cd ~/.emacs.d
;; % git submodule add git://github.com/auto-complete/auto-complete.git elisp/auto-complete
;; % cd ~/.emacs.d/elisp/auto-complete
;; % git submodule init
;; % git submodule update
;; % make byte-compile

;; % git submodule add git://github.com/ejmr/php-mode.git elisp/php-mode
;; % git submodule add git://github.com/tetsujin/emacs-php-align.git elisp/emacs-php-align
;; (auto-install-from-url "http://www.ne.jp/asahi/alpha/kazu/pub/emacs/phpdoc.el")
;; % git submodule add git://github.com/imakado/php-completion elisp/php-completion

;; % git submodule add git://github.com/imakado/emacs-smartchr.git elisp/emacs-smartchr

;; web-mode
;; % git submodule add git://github.com/fxbois/web-mode.git elisp/web-mode

;; cc-mode
;; (auto-install-from-emacswiki "c-eldoc.el")

;; css-mode
;; % git submodule add git://github.com/antonj/scss-mode.git elisp/scss-mode

;; migemo
;; % git submodule add git://github.com/emacs-jp/migemo.git elisp/migemo

;; % git submodule add git://github.com/m2ym/popwin-el.git elisp/popwin-el

;; misc
;; (auto-install-batch "sequential-command")
;; (auto-install-from-emacswiki "key-chord.el")
;; (auto-install-from-emacswiki "accelerate.el")
;; (auto-install-from-emacswiki "redo+.el")
;; (auto-install-from-emacswiki "color-moccur.el")
;; (auto-install-from-emacswiki "moccur-edit.el")
;; (auto-install-from-emacswiki "point-undo.el")
;; (auto-install-from-url "http://cx4a.org/pub/undohist.el")
;; (auto-install-from-url "http://ftp.azc.uam.mx/mirrors/gnu/emacs-lisp/archive/dircolors.el")
;; (auto-install-from-url "http://homepage3.nifty.com/satomii/software/jaspace.el")
;; (auto-install-from-url "http://www.pitecan.com/papers/JSSSTDmacro/dmacro.el")
;; (auto-install-from-url "http://cx4a.org/pub/undohist.el")


(provide 'conf-auto-install)
