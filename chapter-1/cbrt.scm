(define (cbrt x)

  (define (iter guess)
    (if (good-enough? guess)
      guess
      (iter (improve guess))))

  (define (good-enough? guess)
    (< (abs (- (* guess guess guess) x)) 0.001))

  (define (improve guess)
    (/ (+ (* 2 guess) (/ x (* guess guess))) 3))

  (iter 1.0))
