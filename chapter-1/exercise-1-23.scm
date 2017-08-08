(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))

  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          ((= test-divisor 2) (find-divisor n 3))
          (else (find-divisor n (+ test-divisor 2)))))

  (define (divides? a b) (= (remainder b a) 0))

  (= n (smallest-divisor n)))
