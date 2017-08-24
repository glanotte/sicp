(define random-init (random 1000000))
(define (rand-update n) (random 1000000))
(define rand
  (let ((x random-init))
    (lambda ()
      (set! x (rand-update x))
      x)))

(define (map-successive-pairs f s)
  (cons-stream
    (f (stream-car s) (stream-car (stream-cdr s)))
    (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define random-numbers
  (cons-stream
    random-init
    (my-stream-map rand-update random-numbers)))

(define cesaro-stram
  (map-successive-pairs
    (lambda (r1 r2) (= (gcd r1 r2) 1))
    random-numbers))


(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1) failed)
    (next passed (+ failed 1))))

(define pi
  (my-stream-map
    (lambda (p) (sqrt (/ 6 p)))
    (monte-carlo cesaro-stram 1 1)))
