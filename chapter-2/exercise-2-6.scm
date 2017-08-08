(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n) (lambda (f) (lambda (x) (f ((n f) x)))))
(define one (add-1 zero))
(define two (add-1 one))
(define (add-church m n)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

(define four (add-church two two))
((four inc) 0)
