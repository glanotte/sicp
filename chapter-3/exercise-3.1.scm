(define (make-accumulator total)
  (define (acc amount)
    (begin (set! total (+ total amount))
           total))
  acc)

(define A (make-accumulator 5))
(A 10)
(A 10)
