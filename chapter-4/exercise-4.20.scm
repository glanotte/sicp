(define (eval expr env)
  (cond ((self-evaluating? expr) expr)
        ((variable? expr) (lookup-variable-value expr env))
        ((quoted? expr) (text-of-quotation expr))
        ((let? expr) (eval-let expr env))
        ((letrec? expr) (eval-letrec expr env))
        ((assignment? expr) (eval-assignment expr env))
        ((definition? expr) (eval-definition expr env))
        ((if? expr) (eval-if expr env))
        ((lambda? expr)
         (make-procedure (lambda-parameters expr)
                         (lambda-body expr)
                         env))
        ((begin? expr)
         (eval-sequence (begin-actions expr) env))
        ((cond? expr) (eval (cond->if expr) env))
        ((application? expr)
         (my-apply (eval (operator expr) env)
                   (list-of-values (operands expr) env)))
        (else
          (error "Unknown expression type: EVAL" exp))))

(define (my-apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure arguments))
        ((compound-procedure? procedure)
         (eval-sequence
           (procedure-body procedure)
           (extend-environment
             (procedure-parameters procedure)
             arguments
             (procedure-environment procedure))))
        (else
          (error "Unknown procedure type: APPLY" procedure))))

(define (list-of-values exps env)
  (if (no-operands? exps)
    '()
    (cons (eval (first-operand exps) env)
          (list-of-values (rest-operands exps) env))))

(define (eval-if expr env)
  (if (true? (eval (if-predicate expr) env))
    (eval (if-consequent expr) env)
    (eval (if-alternative expr) env)))

(define (eval-sequence exps env)
  (cond ((last-exp? exps)
         (eval (first-exp exps) env))
        (else
          (eval (first-exp exps) env)
          (eval-sequence (rest-exps exps) env))))
(define (eval-assignment expr env)
  (set-variable-value! (assignment-variable expr)
                       (eval (assignment-value expr) env)
                       env)
  'ok)
(define (eval-definition expr env)
  (define-variable! (definition-variable expr)
                    (eval (definition-value expr) env)
                    env)
  'ok)

;;; 4.1.2

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
          (error "ELSE clause isn't last: COND->IF"
                  clauses))
        (make-if (cond-predicate first)
                 (sequence->exp (cond-actions first))
                 (expand-clauses rest))))))
;;; Ex 4.16 (scan-out-defines)
(define (my-filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (my-filter predicate (cdr sequence))))
        (else (my-filter predicate (cdr sequence)))))
(define (my-remove predicate sequence)
  (cond ((null? sequence) nil)
        ((not (predicate (car sequence)))
         (cons (car sequence)
               (my-remove predicate (cdr sequence))))
        (else (my-remove predicate (cdr sequence)))))

;(define (f n) (define (g x) (+ 1 x)) (define (h y) (+ 2 y)) (+ (g n) (h n)))
; (define (fn n) (define g 1) (+ g 3))

(define (make-let bindings body)
  (cons 'let (cons bindings body)))

(define (scan-out-defines proc-body)
  (let ((definitions (my-filter definition? proc-body))
        (rest-body (my-remove definition? proc-body)))
    (if (null? definitions)
      proc-body ;;nothing to do
      (let ((vars (map definition-variable definitions)))
        (let ((bindings (map (lambda (var) (list var 0)) vars))
              (assigns (map (lambda (def) (list 'set!
                                                (definition-variable def)
                                                (definition-value def)))
                            definitions)))
          (list (make-let bindings (append assigns rest-body))))))))
;;; 4.1.3

(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))
(define (contain-defines exps)
   (if (null? exps)
     false
     (or (if (definition? (car exps))
           true
           false)
         (contain-defines (cdr exps)))))
(define (make-procedure parameters body env)
  (display "procedure parms: ")(display parameters)(newline)
  (display "procedure body ")(display body)(newline)
  (if (contain-defines body)
    (list 'procedure parameters (scan-out-defines body) env)
    (list 'procedure parameters body env)))

(define (compound-procedure? p)
  (tagged-list? p 'procedure))
(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
(define (procedure-environment p) (cadddr p))

(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())
(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
    (cons (make-frame vars vals) base-env)
    (if (< (length vars) (length vals))
      (error "Too many arguments supplied" vars vals)
      (error "too few arguments supplied" vars vals))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((and (eq? var (car vars)) (eq? (car vals) '*unassigned*))
             (error "Variable is unassigned" var))
            ((eq? var (car vars)) (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "Unbound variable" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars)) (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
      (error "unbound variable: SET!" var)
      (let ((frame (first-frame env)))
        (scan (frame-variables frame)
              (frame-values frame)))))
  (env-loop env))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars)) (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame) (frame-values frame))))
;;; Exercise 4.6 - let

; (define (let? expr) (tagged-list? expr 'let))
(define (eval-let exp env)
  (display "eval let: ")(display (eval (let->combination exp) env)) (newline)
  (eval (let->combination exp) env))
 (define (let? expr) (tagged-list? expr 'let))
 (define (let-vars expr) (map car (cadr expr)))
 (define (let-inits expr) (map cadr (cadr expr)))
 (define (let-body expr) (cddr expr))

 (define (let->combination expr)
   (cons (make-lambda (let-vars expr) (let-body expr))
         (let-inits expr)))

;;; 4.1.4

(define (setup-environment)
  (let ((initial-env
          (extend-environment (primitive-procedure-names)
                              (primitive-procedure-objects)
                              the-empty-environment)))
    (define-variable! 'true true initial-env)
    (define-variable! 'false false initial-env)
    initial-env))
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))
(define (primitive-implementation proc) (cadr proc))
(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list '+ +)
        (list '- -)
        (list '= =)
        (list '* *)
        (list 'null? null?)))
(define (primitive-procedure-names)
  (map car primitive-procedures))
(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))
(define (apply-primitive-procedure proc args)
  (apply-in-underlying-scheme
    (primitive-implementation proc) args))
(define input-prompt ";;; M-Eval input:")
(define output-prompt ";;; M-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))
(define apply-in-underlying-scheme apply)
(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))
(define (announce-output string)
  (newline) (display string) (newline))
(define (user-print object)
  (if (compound-procedure? object)
    (display (list 'compound-procedure
                   (procedure-parameters object)
                   (procedure-body object)
                   '<procedure-env>))
    (display object)))

;; exercise 4.20 - letrec

; (letrec
;   ((fact (lambda (n)
;            (if (= n 1)
;              1
;              (* n (fact (- n 1)))))))
;   (fact 10))

(define (letrec? expr) (tagged-list? expr 'letrec))
(define (eval-letrec expr env) (eval (letrec->let expr) env))
(define (letrec->let expr)
  (let ((vars (map (lambda (var) (list var 0))
                   (let-vars expr)))
        (set-vars (map (lambda (init) (cons 'set! init))
                       (cadr expr)))
        (body (let-body expr)))
    (make-let vars (append set-vars body))))

(define the-global-environment (setup-environment))
(driver-loop)
