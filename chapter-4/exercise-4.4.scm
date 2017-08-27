(define syntax-table (make-table))
(define (get op) (syntax-table 'lookup-proc op))
(define (put op proc) (syntax-table 'insert-proc op proc))

(put 'quote (lambda (x y) (text-of-quotation x)))
(put 'set! eval-assignment)
(put 'define eval-definition)
(put 'lambda (lambda (x y) (make-procedure (lambda-parameters x)
                                           (lambda-body x)
                                           y)))
(put 'if eval-if)
(put 'and eval-and)
(put 'or eval-or)
(put 'begin (lambda (x y) (eval-sequence (begin-actions x) y)))
(put 'cond (lambda (x y) (eval (cond->if x) y)))

(define (make-or exps) (cons 'or exps))
(define (eval-or expr env)
  (if (true? (eval (first-exp expr) env))
    'true
    (if (last-exp? expr)
      'false
      (eval (make-or rest-exps) env))))

(define (make-and exps) (cons 'and exps))
(define (eval-and expr env)
  (if (true? (eval (first-exp expr) env))
    (if (last-exp? expr)
      'true
      (eval (make-and rest-exps) env))
    'false))


(define (eval expr env)
  (cond ((self-evaluating? expr) expr)
        ((variable? expr) (lookup-variable-value expr env))
        ((get (car expr)) ((get (car expr))))
        ((application? expr)
         (apply (eval (operator expr) env)
                (list-of-values (operands expr) env)))
        (else
          (error "Unknown expression type: EVAL" exp))))
