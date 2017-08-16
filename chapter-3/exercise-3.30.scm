; (define (full-adder a b c-in sum c-out)
(define (ripple-carry-adder a-wires b-wires s-wires c)
  (let ((a (car a-wires))
        (b (car b-wires))
        (s (car s-wires))
        (c-out (make-wire)))
    (if (not (null? a-wires))
      (full-adder a b c s c-out)
      (ripple-carry-adder (cdr a-wires) (cdr b-wires) (cdr c-wires) c-out))
    'ok))


