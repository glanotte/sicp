(define (double f)
  (lambda (y) (f (f y))))
(define (inc y) (+ y 1))
((double inc) 1)
