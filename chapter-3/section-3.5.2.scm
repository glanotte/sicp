(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))
(define integers (integers-starting-from 1))

(define (divisible? x y) (= (remainder x y) 0))
(define (sieve stream)
  (cons-stream
    (stream-car stream)
    (sieve (my-stream-filter
             (lambda (x)
               (not (divisible? x (stream-car stream))))
             (stream-cdr stream)))))
(define primes (sieve (integers-starting-from 2)))
; (stream-ref primes 50)

(define ones (cons-stream 1 ones))
(define (my-add-streams s1 s2) (my-stream-map + s1 s2))
(define integers
  (cons-stream 1 (my-add-streams ones integers)))
; (stream-ref integers 10)
(define fibs
  (cons-stream
    0
    (cons-stream 1 (my-add-streams (stream-cdr fibs) fibs))))
(stream-ref fibs 10)
