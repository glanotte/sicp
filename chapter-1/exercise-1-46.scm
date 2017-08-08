(define (iterative-improve good-enough? improve)
  (lambda (f x first-guess)
    (define (iter guess)
      (if (good-enough? guess x)
        guess
        (iter (improve guess))))))

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (iterative-improve
    (lambda (v1 v2)
    (< (abs (- v1 v2))
       tolerance))
    f))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (define tolerance 0.00001)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(define (sqrt x)
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (average x y)
    (/ (+ x y) 2))
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (sqrt-iter 1.0 x))
