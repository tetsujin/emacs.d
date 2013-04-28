(defalias 'perl-mode 'cperl-mode)

(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(setq interpreter-mode-alist
      (append interpreter-mode-alist
              '(("miniperl" . cperl-mode))))

(defun my-cperl-mode-hook ()
  ;; perl-completion
  (when (require 'perl-completion nil t)
    (setq plcmp-buffer-dabbrev-expansions-number 0)
    (perl-completion-mode t))
  
  (define-key cperl-mode-map "\M-\C-p" 'perl-eval)
  (define-key cperl-mode-map "\C-j" 'anything-dabbrev-expand)
  (setq cperl-indent-parens-as-block t
        cperl-close-paren-offset -4
        cperl-indent-level 4
        cperl-label-offset -4
        cperl-continued-statement-offset 4
        cperl-highlight-variables-indiscriminately t
        cperl-font-lock t
        indent-tabs-mode nil
        ;;                   cperl-auto-newline t
        cperl-comment-column 40)
  ;; face
  (set-face-bold-p 'cperl-array-face nil)
  (set-face-background 'cperl-array-face nil)
  (set-face-bold-p 'cperl-hash-face nil)
  (set-face-background 'cperl-hash-face nil)
  ;; override
  (setq yas/trigger-key "\C-cy")
  (define-key cperl-mode-map "\C-co" 'anything-c-yas-complete)
  (yas/minor-mode-on)
  (flymake-perl-load)

  (when (require 'perl-debug nil t)
    ;;             (perl-debug-set-coding-system)
    ;;             (define-key cperl-mode-map "\C-cd" 'perl-debug-lint)
    (define-key cperl-mode-map "\C-c\C-d" 'perl-debug) ; デバッガの起動
    (autoload 'perl-debug "perl-debug" nil t)
    (autoload 'perl-debug-lint "perl-debug" nil t))
  )

(add-hook 'cperl-mode-hook 'my-cperl-mode-hook)

(defalias 'perl-mode 'cperl-mode)
(autoload 'cperl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region beg end "perl -w"))

(defun perltidy-region (beg end)
  "Run perltidy on the current region."
  (interactive "r")
  (shell-command-on-region beg end "perltidy -q" nil t))

;; (defun my-cperl-mode-hook ()
;;   ;; perl-completion
;;   ;; http://svn.coderepos.org/share/lang/elisp/perl-completion/
;;   (require 'perl-completion)
;;   (setq plcmp-buffer-dabbrev-expansions-number 0)
;;   (perl-completion-mode t)
;;   (define-key plcmp-mode-map "\C-cd" nil)
;;   (define-key plcmp-mode-map "\C-ca" nil)

;;   ;; perl-debug
;;   ;; http://www.namazu.org/~tsuchiya/elisp/perl-debug.el
;;   (require 'perl-debug)
;;   (define-key cperl-mode-map "\C-c\C-d" 'perl-debug)

;;   ;; set-perl5lib
;;   (require 'set-perl5lib)

;;   (setq cperl-indent-parens-as-block t
;;         cperl-close-paren-offset -4
;;         cperl-indent-level 4
;;         cperl-label-offset -4
;;         cperl-continued-statement-offset 4
;;         cperl-highlight-variables-indiscriminately t
;;         cperl-font-lock t
;;         ;;cperl-auto-newline t
;;         cperl-comment-column 40)
;;   (set-face-bold-p 'cperl-array-face nil)
;;   (set-face-background 'cperl-array-face nil)
;;   (set-face-bold-p 'cperl-hash-face nil)
;;   (set-face-background 'cperl-hash-face nil)

;;   ;; keymap
;;   (define-key cperl-mode-map "\M-\C-p" 'perl-eval)
;;   (define-key cperl-mode-map "\C-ct" 'perltidy-region)
;;   (define-key cperl-mode-map "\C-j" nil)
;;   (define-key cperl-mode-map "\C-cy" nil)
;;   (define-key cperl-mode-map "\C-o" nil)
;;   )

;; (add-hook 'cperl-mode-hook 'my-cperl-mode-hook)


(provide 'conf-cperl-mode)
