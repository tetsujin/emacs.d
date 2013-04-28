(defconst *dmacro-key* (kbd "C-t") "dmacro key")
(autoload 'dmacro-exec "dmacro" nil t)
(global-set-key *dmacro-key* 'dmacro-exec)

(provide 'conf-dmacro)
