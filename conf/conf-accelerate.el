(when (require 'accelerate nil t)
  (accelerate previous-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
  (accelerate next-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
  (accelerate smooth-scroll-down '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
  (accelerate smooth-scroll-up '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
  (accelerate dired-previous-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3))
  (accelerate dired-next-line '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 3 3)))

(provide 'conf-accelerate)

  
