(define (square x) (* x x))
(define (prime? n)
  (define (smallest-divisor n) (find-divisor n 2))

  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          ((= test-divisor 2) (find-divisor n 3))
          (else (find-divisor n (+ test-divisor 2)))))

  (define (divides? a b) (= (remainder b a) 0))

  (= n (smallest-divisor n)))

(define the-empty-stream '())
(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))
(define (stream-map proc s)
  (if (stream-null? s)
    the-empty-stream
    (cons-stream (proc (stream-car s))
                 (stream-map proc (stream-cdr s)))))
(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))
(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))

(define (stream-enumerate-interval low high)
  (if (> low high)
    the-empty-stream
    (cons-stream
      low
      (stream-enumerate-interval (+ low 1) high))))
(define (my-stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (my-stream-filter
                        pred
                        (stream-cdr stream))))
        (else (my-stream-filter pred (stream-cdr stream)))))

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
        (begin (set! result (proc))
               (set! already-run? true)
               result)
        result))))

; (define (stream-delay expr) (memo-proc (lambda () (expr))))
; (define (stream-force delayed-object) (delayed-object))
; (define (cons-stream x y) (cons x (stream-delay y)))


(stream-car
  (stream-cdr
    (my-stream-filter prime?
                   (stream-enumerate-interval
                     10000 1000000))))
