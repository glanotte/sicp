(define (pascal n)
  (if (= n 1)
    1
    (+ (expt 2 (- n 1)) (pascal (- n 1)))))
