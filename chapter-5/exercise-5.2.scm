; (define (factorial n)
;   (define (iter product counter)
;     (if (> counter n)
;       product
;       (iter (* counter product)
;             (+ counter 1))))
;   (iter 1 1))
(controller
  test-c
    (test (op >) (reg c) (reg n))
    (branch (label fact-done))
    (assign p (op *) (reg c) (reg p))
    (assign c (op +) (reg c) (const 1))
    (goto (label test-c))
  fact-done)

