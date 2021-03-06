(define (self-evaluating? expr)
  (cond ((number? expr) true)
        ((string? expr) true)
        (else false)))
(define (variable? expr) (symbol? expr))
(define (quoted? expr) (tagged-list? expr 'quote))
(define (text-of-quotation expr) (cadr expr))
(define (tagged-list? expr tag)
  (if (pair? expr)
    (eq? (car expr) tag)
    false))
(define (assignment? expr) (tagged-list? expr 'set!))
(define (assignment-variable expr) (cadr expr))
(define (assignment-value expr) (caddr expr))
(define (definition? expr) (tagged-list? expr 'define))
(define (definition-variable expr)
  (display "DEF VAR: ")(display expr)(newline)
  (if (symbol? (cadr expr))
    (cadr expr)
    (caadr expr)))
(define (definition-value expr)
  (if (symbol? (cadr expr))
    (caddr expr)
    (make-lambda (cdadr expr)
                 (cddr expr))))
(define (lambda? expr) (tagged-list? expr 'lambda))
(define (lambda-parameters expr) (cadr expr))
(define (lambda-body expr) (cddr expr))
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
(define (if? expr) (tagged-list? expr 'if))
(define (if-predicate expr) (cadr expr))
(define (if-consequent expr) (caddr expr))
(define (if-alternative expr)
  (if (not (null? (cdddr expr)))
    (cadddr expr)
    'false))
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
(define (begin? expr) (tagged-list? expr 'begin))
(define (begin-actions expr) (cdr expr))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))
(define (application? expr) (pair? expr))
(define (operator expr) (car expr))
(define (operands expr) (cdr expr))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))
(define (cond? expr) (tagged-list? expr 'cond))
(define (cond-clauses expr) (cdr expr))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if expr) (expand-clauses (cond-clauses expr)))
(define (expand-clauses clauses)
  (if (null? clauses)
    'false
    (let ((first (car clauses))
          (rest (cdr clauses)))
      (if (cond-else-clause? first)
        (if (null? rest)
          (sequence->exp (cond-actions first))
          (errror "ELSE clause isn't last: COND->IF"
                  clauses))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))
