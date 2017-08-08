(define (repeated f n)
  (lambda (x) (if (= n 1)
                (f x)
                (f ((repeated f (- n 1)) x)))))

(define (nth-root x n)
  (fixed-point
    ((repeated average-damp (- n 2))
     (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

(nth-root 625 3)

(define (sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y))) 1.0))
