(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

; left to right
(define (list-of-values-lr exps env)
  (if (no-operands? exps)
    '()
    (let ((left (eval (first-operand exps) env)))
      (let ((right (eval (rest-operands exps) env)))
    (cons left right)))))

; right to left
(define (list-of-values-rl exps env)
  (if (no-operands? exps)
    '()
    (let ((right (eval (rest-operand exps) env)))
      (let ((left (eval (first-operands exps) env)))
    (cons left right)))))
