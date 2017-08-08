; linear
(define (mult a b)
  (if (= b 0)
    0
    (+ a (mult a (- b 1)))))

(define (mult a b)
  (define (double x)
    (+ x x))
  (define (halve x)
    (/ x 2))

  (cond ((= b 0) 0)
        ((even? b) (mult (double a) (halve b)))
        (else (+ a (mult a (- b 1))))))

