(define f (let ((n 1))
            (lambda (x)
              (begin (set! n (* x n))
                     n))))


(+ (f 1) (f 0))
(+ (f 0) (f 1))
