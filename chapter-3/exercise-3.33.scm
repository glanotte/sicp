(define (averager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (adder a b x)
    (multiplier y c x)
    (constant 2 y))
  'ok)

(define A (make-connector))
(define B (make-connector))
(define C (make-connector))

(probe "one: " A)
(probe "two " B)
(probe "avg " C)
(averager A B C)

(set-value! A 3 'user)
(set-value! C 8 'user)



