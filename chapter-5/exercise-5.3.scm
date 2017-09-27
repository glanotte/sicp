; (define (sqrt x)
;   (define (good-enough? guess)
;     (< (abs (- (square guess) x)) 0.001))
;   (define (improve guess)
;     (average guess (/ x guess)))
;   (define (sqrt-iter guess)
;     (if (good-enough? guess)
;       guess
;       (sqrt-iter (improve guess))))
;   (sqrt-iter 1.0))

(controller
  test-g
    (test (op good-enough?) (reg g))
    (branch (label sqrt-done))
    (assign g (op improve) (reg g))
    (goto (label test-g))
  sqrt-done)

;; expanding primitives

(controller
  (assign x (op read))
  test-g
    (test (op <)
          ((op abs) ((op -) (op *) (reg g) (reg g)))
          (const 0.001))
    (branch (label sqrt-done))
    (assign g (op average) (reg g) ((op /) (reg x) (reg g)))
    (goto (label test-g))
  sqrt-done)
