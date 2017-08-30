(define (search-env env found-proc not-found-proc)
  (define (scan vars vals)
    (cond ((null? vars) (not-found-proc env))
          ((eq? var (car vars)) (found-proc (vars vals)))
          (else (scan (cdr vars) (cdr vals)))))
  (if (eq? env the-empty-environment)
    (error "Unbound variable" var)
    (let ((frame (first-frame env)))
      (scan (frame-variables frame)
            (frame-values frame)))))

(define (deep-search-env env found-proc)
  (search-env env
              found-proc
              (lambda (env)
                (search-env (enclosing-environment env)))))

(define (lookup-variable-value var env)
  (deep-search-env env
                   (lambda (vars vals) (car vals))))

(define (set-variable-value! var val env)
  (deep-search-env env
                   (lambda (env) (set-car! vals val))))

(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (search-env env
                (lambda (var vals) (set-car! vals val))
                (lambda (env) (add-binding-to-frame! var val frame)))))

(define (make-unbound! var env)
  (search-env env
              (lambda (var vals) (begin (set-car! (cdr vars))
                                        (set-cdr! (cdr vals))))
              (lambda (var vals) (error "nothing to unbind" var))))
