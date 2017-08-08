(define (search f neg-point pos-point)
  (define (close-enough? x y) (< (abs (- x y)) 0.001))
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
      midpoint
      (let ((test-value (f midpoint)))
        (cond ((positive? test-value)
               (search f neg-point midpoint))
              ((negative? test-value)
               (search f midpoint pos-point))
              (else midpoint))))))
(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value) (positive? b-value))
           (search f a b))
          ((and (negative? b-value) (positive? a-value))
           (search f b a))
          (else (error "Values are not of opposite sign" a b)))))

(half-interval-method sin 2.0 4.0)


(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (newline) (display "guess: ") (display guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

(fixed-point (lambda (y) (+ (sin y) (cos y))) 1.0)

(define (sqrt x)
  (fixed-point (lambda (y) (average y (/ x y))) 1.0))

(define (phi)
  (fixed-point (lambda (y) (+ 1 (/ 1 y))) 1.0))

(fixed-point (lambda (y) (/ (log 1000) (log y))) 10.0)
