
;; リージョン内の末尾空白を削除
(defun rtrim-region (beg end)
  "Trim a dust in selected region"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char beg)
      (while (re-search-forward "[ \t]+$" nil t)
        (replace-match "" nil nil)))))
(define-key global-map (kbd "C-x C-t") 'rtrim-region)

;; リージョン内のHTMLタグ除去
(defun html-tag-remove-region (beg end)
  "remove html tags in selected region"
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char beg)
      (while (re-search-forward "<[^%?][^>]+>" nil t)
        (replace-match "" nil nil)))))

;; toggle-truncate-linesの結果でtruncate-partial-width-windowsも合わせる
;; (defun my-toggle-truncate-lines ()
;;   (interactive)
;;   (toggle-truncate-lines)
;;   (setq truncate-partial-width-windows truncate-lines))


;; http://dev.ariel-networks.com/Members/matsuyama/tokyo-emacs-02
;; 行をコピーするコマンド
(defun copy-line (&optional arg)
  (interactive "p")
  (copy-region-as-kill
   (line-beginning-position)
   (line-beginning-position (1+ (or arg 1))))
  (message "Line copied"))

(cond
 ((= emacs-major-version 23)
  ;; リージョンを選択していないときに行をキルするコマンド(Emacs 23 and advice版)
  (defadvice kill-region (around kill-line-or-kill-region activate)
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (kill-whole-line)
      ad-do-it))
  ;; リージョンを選択していないときに行をコピーするコマンド(Emacs 23+advice版)
  (defadvice kill-ring-save (around kill-line-save-or-kill-ring-save activate)
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (copy-line)
      ad-do-it))) 
 ((= emacs-major-version 22)
  ;; 同上(Emacs 22 or 非advice版)
  (defun kill-line-or-region (beg end)
    (interactive (list (point) (mark t)))
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (kill-whole-line 1)
      (kill-region beg end)))
  (global-set-key (kbd "C-w") 'kill-line-or-region)
  ;; 同上(Emacs 22 or 非advice版)
  (defun kill-line-or-region-save (beg end)
    (interactive (list (point) (mark t)))
    (if (and (interactive-p) transient-mark-mode (not mark-active))
        (copy-line)
      (kill-ring-save beg end)))
  (global-set-key (kbd "M-w") 'kill-line-or-region-save)))

;; http://d.hatena.ne.jp/IMAKADO/20091209/1260323922
(defun ik:decamelize (string)
  "Convert from CamelCaseString to camel_case_string."
  (let ((case-fold-search nil))
    (downcase
     (replace-regexp-in-string
      "\\([A-Z]+\\)\\([A-Z][a-z]\\)" "\\1_\\2"
      (replace-regexp-in-string
       "\\([a-z\\d]\\)\\([A-Z]\\)" "\\1_\\2"
       string)))))
(defun ik:camerize<->decamelize-on-region (s e)
  (interactive "r")
  (let ((buf-str (buffer-substring-no-properties s e))
        (case-fold-search nil))
    (cond
     ((string-match "_" buf-str)
      (let* ((los (mapcar 'capitalize (split-string buf-str "_" t)))
             (str (mapconcat 'identity los "")))
        ;; snake case to camel case
        (delete-region s e)
        (insert str)))
     (t
      (let* ((str (ik:decamelize buf-str)))
        ;; snake case to camel case
        (delete-region s e)
        (insert str))))))

(provide 'conf-function)
