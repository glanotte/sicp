(define (my-cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (my-car x)
  (let ((y (remainder x 2)))
    (if (= y 0)
      (+ 1 (my-car (/ x 2)))
      0)))

(define (my-cdr x)
  (let ((y (remainder x 3)))
    (if (= y 0)
      (+ 1 (my-cdr (/ x 3)))
      0)))

(define test (my-cons 10 4))
(my-car test)
(my-cdr test)
