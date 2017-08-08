(define (mult a b)
  (define (iter a b c)
    (cond ((= b 0) 0)
          ((even? b) (iter (double a) (halve b) c))
          (else (+ a (iter a (- b 1) (+ b c))))))

  (define (double x)
    (+ x x))

  (define (halve x)
    (/ x 2))

  (iter a b 1))
