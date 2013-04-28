;; http://d.hatena.ne.jp/Tetsujin/20090527/1243436153
(when (require 'smartchr nil t)

  (defun smartchr-if (list-of-string condition)
    (lexical-let ((f (smartchr list-of-string))
                  (c condition))
      (lambda (arg)
        (interactive "p")
        (if (and (= arg 1) (funcall c))
            (funcall f)
          (self-insert-command arg)))))

  (defmacro smartchr-if-face (list-of-string list-of-face)
    `(smartchr-if ,list-of-string
                  (lambda ()
                    (memq (get-text-property (point) 'face)
                          ,list-of-face)))))

(provide 'conf-smartchr)
