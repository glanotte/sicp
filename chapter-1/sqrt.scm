(define (sqrt x)
  (define (iter guess)
    (if (good-enough? guess)
      guess
      (iter (improve guess))))

  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))

  (define (improve guess)
    (average guess (/ x guess)))

  (iter 1.0))
