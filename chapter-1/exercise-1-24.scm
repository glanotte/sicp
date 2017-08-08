(define (search-for-primes start count)
  (cond ((= count 0) (newline) (display " found count "))
        ((odd? start) (if (timed-prime-test start)
                        (search-for-primes (+ start 2) (- count 1))
                        (search-for-primes (+ start 2) count)))
        (else (search-for-primes (+ start 1) count))))

(define (timed-prime-test n)
  (newline) (display n) (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (fast-prime? n 100)
    (report-prime (- (runtime) start-time)))
  (fast-prime? n 100))
(define (report-prime elapsed-time)
  (display " *** ") (display elapsed-time))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))
(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))
(define (expmod base exp m)
  (cond ((= exp 0)
         1)
        ((even? exp)
         (remainder
           (square
             (expmod base (/ exp 2) m))
           m))
        (else
          (remainder
            (* base
               (expmod base (- exp 1) m))
            m))))
