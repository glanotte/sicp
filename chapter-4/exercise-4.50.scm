(load "amb-evaluator.scm")

(define (analyze exp)
  (cond ((self-evaluating? exp) (analyze-self-evaluating exp))
        ((quoted? exp) (analyze-quoted exp))
        ((variable? exp) (analyze-variable exp))
        ((assignment? exp) (analyze-assignment exp))
        ((definition? exp) (analyze-definition exp))
        ((if? exp) (analyze-if exp))
        ((amb? exp) (analyze-amb exp))
        ((ramb? exp) (analyze-ramb exp))
        ((lambda? exp) (analyze-lambda exp))
        ((begin? exp) (analyze-sequence (begin-actions exp)))
        ((cond? exp) (analyze (cond->if exp)))
        ((application? exp) (analyze-application exp))
        (else (error "Unknown expression type: ANALYZE" exp))))

(define (ramb? exp) (tagged-list? exp 'ramb))

(define (analyze-ramb exp)
  (let ((cprocs (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
          (fail)
          (let* ((random-choice (rnd choices))
                 (rest-choices (delete random-choice choices)))
            (random-choice
             env
             succeed
             (lambda () (try-next rest-choices))))))
      (try-next cprocs))))

(define (rnd list)
  (list-ref list (random (length list))))

(define (delete item list)
  (if (null? list)
    '()
    (if (eq? item (car list))
      (cdr list)
      (cons (car list) (delete item (cdr list))))))
