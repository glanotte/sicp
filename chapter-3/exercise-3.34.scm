(define (squarer a b)
  (multiplier a a b))

(define A (make-connector))
(define B (make-connector))
(probe "other " A)
(probe "square " B)
(set-value! A 2 'user)
(set-value! B 4 'user)
(squarer A B)
