(when (require 'anything-startup nil t)

  ;; AnythingをMigemo対応にする
  (when (and (executable-find "cmigemo")
             (require 'migemo nil t))
    (when (require 'anything-migemo nil t)
      ;; kill-bufferが"Wrong type argument: number-or-marker-p, nil"になるので書き換え
      ;; 参考: http://d.hatena.ne.jp/Tan90909090/20120928/1348765648
      (setq anything-use-migemo nil)
      (defun anything-other-buffer (any-sources any-buffer)
        (anything-migemo t :sources any-sources :buffer any-buffer))
      ))

  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3

   ;; タイプして再描写するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2

   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100

   ;; 候補が多い時に体感速度を早くする
   ;; これをtにするとkill-bufferが何故か動かない
   ;; anything-quick-update t

   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet

   ;; root権限でアクションを実行するときのコマンド デフォルトはsu
   anything-su-or-sudo "sudo"

   ;; read-*, completing-readをanythingのものに置き換える
   anything-read-string-mode t)

  (defun my-anything-filelist+ ()
    (interactive)
    (anything-other-buffer
     '(anything-c-source-files-in-current-dir+
       anything-c-source-buffers+
       anything-c-source-recentf
       anything-c-source-mac-spotlight
       anything-c-source-locate)
     "*my-anything-filelist+*"))

  (define-key global-map (kbd "C-'") 'my-anything-filelist+)
  (define-key global-map (kbd "M-'") 'my-anything-filelist+)

  (define-key global-map (kbd "M-x") 'anything-M-x)
  (define-key global-map (kbd "C-x b") 'anything-buffers+)

  ;; バッファ切替
  ;; (defun my-anything-buffers ()
  ;;   (interactive)
  ;;   (anything '(anything-c-source-buffers+)))
  ;;(anything-iswitchb-setup)

  ;; (defun my-anything-minibuf ()
  ;;   (interactive)
  ;;   (anything '(anything-c-source-emacs-commands
  ;;               ;;anything-c-source-emacs-functions-with-abbrevs
  ;;               ;;anything-c-source-emacs-variables
  ;;               )))
  ;; (define-key global-map (kbd "C-M-x") 'my-anything-minibuf)

  ;; kill-ringのAnythingインタフェース
  (define-key global-map (kbd "M-y") 'anything-show-kill-ring)

  ;; color-moccurのAnythingインタフェース
  (when (require 'anything-c-moccur nil t)
    (setq
     ;; anything-c-moccur用 `anything-idle-delay'
     anything-c-moccur-anything-idle-delay 0.1
     ;; バッファの情報をハイライトする
     anything-c-moccur-highlight-info-line-flag t
     ;; 現在選択中の候補の一を他のwindowに表示する
     anything-c-moccur-enable-auto-look-flag t
     ;; 起動時にポイントの一の単語を初期パターンにする
     anything-c-moccur-enable-initial-pattern t)
    (define-key global-map (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))

  ;; anything-dabbrev-expand
  ;; anything-dabbrev-expand
  (when (require 'anything-dabbrev-expand nil t)
    (unless (executable-find "ruby")
      (setq anything-dabbrev-sources
            '(anything-dabbrev-source
              anything-dabbrev-all-source))
      (setq anything-dabbrev-expand-strategies
            '(anything-dabbrev-expand--first-dabbrev
              anything-dabbrev-expand--anything)))
    (define-key global-map (kbd "C-j") 'anything-dabbrev-expand)
    (define-key anything-dabbrev-map (kbd "C-j") 'anything-dabbrev-find-all-buffers))

  ;; anything-yaetags
  (when (require 'anything-yaetags nil t)
    (defun my-anything-yaetags ()
      (interactive)
      (anything-other-buffer '(anything-c-source-yaetags-select)))
    (define-key global-map (kbd "C-x C-@") 'anything-yaetags-find-tag)
    (define-key global-map (kbd "M-.") 'anything-yaetags-find-tag)
    (define-key global-map (kbd "C-.") 'my-anything-yaetags))

  ;; anything-project
  (when (require 'anything-project nil t)
    (global-set-key (kbd "C-c C-f") 'anything-project)
    ;; (global-set-key (kbd "C-c C-g") 'anything-project-grep)

    ;; ディレクトリを含まないようにする
    (setq ap:project-files-filters
          (list
           (lambda (files)
             (remove-if 'file-directory-p files))))

    (defun* ap:add-project-ex (&key name look-for (include-regexp ".*") (exclude-regexp nil) (exclude-directory-regexp nil) (grep-extensions nil) (grep-ignore-dirs nil))
      (ap:add-project
       :name name
       :look-for look-for
       :include-regexp include-regexp
       :exclude-regexp exclude-regexp
       :grep-extensions grep-extensions)
      (nconc (cdr (assq name ap:projects))
             (list (cons :grep-ignore-dirs grep-ignore-dirs))))

    (defun ap:get-grep-extra-options (key)
      (let ((grep-ignore-dirs (ap:get-project-data key :grep-ignore-dirs)))
        (mapconcat 'identity (mapcar (lambda (dir)
                                       (concat "--ignore-dir=" dir))
                                     grep-ignore-dirs) " ")))

    (defun ap:build-grep-command (key)
      (let ((grep-extensions (ap:get-grep-extensions key))
            (ack-command (ap:get-ack-command))
            (grep-extra-options (ap:get-grep-extra-options key))
            (xargs-command (ap:get-xargs-command))
            (egrep-command (ap:get-egrep-command)))
        (concat
         ack-command " -afG " grep-extensions
         " "
         grep-extra-options
         " | "
         xargs-command
         " "
         egrep-command " -Hin "
         "%s")))

    ;; PHP symfony
    (ap:add-project-ex
     :name 'symfony
     :look-for 'ap:symfony-root-detector
     :grep-extensions '("\\.php" "\\.yml")
     :exclude-regexp '("/cache" "/log" "/web/uploads"))

    ;; PHP Symfony2
    (ap:add-project-ex
     :name 'symfony2
     :look-for 'ap:symfony2-root-detector
     :grep-extensions '("\\.php" "\\.twig" "\\.yml")
     :grep-ignore-dirs '("cache" "logs")    ;
     :exclude-regexp  '("/cache/" "/logs/"))
    (defun ap:symfony2-root-detector (files)
      (ap:all-files-exist '("app" "bin" "src" "vendor" "web") files))

    ;; PHP Ethna
    (ap:add-project
     :name 'ethna
     :look-for 'ap:ethna-root-detector
     :grep-extensions '("\\.php" "\\.tpl")
     :exclude-regexp  '("/tmp" "/log"))
    (defun ap:ethna-root-detector (files)
      (ap:all-files-exist '(".ethna" "app" "etc" "www") files))

    (ap:add-project-ex
     :name 'objective-c
     :look-for '("\\.xcodeproj")
     :grep-extensions '("\\.m" "\\.h" "\\.plist")
     :grep-ignore-dirs '(".*\\.xcodeproj" "build")
     :exclude-regexp  '("/.*\\.xcodeproj/" "/build/")))

  ;; yasnippetのAnything用インタフェース
  ;; http://d.hatena.ne.jp/sugyan/20120111/1326288445
  (when (require 'yasnippet nil t)
    (defun my-yas/prompt (prompt choices &optional display-fn)
      (let* ((names (loop for choice in choices
                          collect (or (and display-fn (funcall display-fn choice))
                                      coice)))
             (selected (anything-other-buffer
                        `(((name . ,(format "%s" prompt))
                           (candidates . names)
                           (action . (("Insert snippet" . (lambda (arg) arg))))))
                        "*anything yas/prompt*")))
        (if selected
            (let ((n (position selected names :test 'equal)))
              (nth n choices))
          (signal 'quit "user quit!"))))
    (custom-set-variables '(yas/prompt-functions '(my-yas/prompt))))

  (define-key anything-map (kbd "C-h") 'nil)
  )

(provide 'conf-anything)
