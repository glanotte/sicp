(define (make-monitored proc)
  (let ((counter 0))
    (define (call-proc arg)
      (if (eq? arg 'how-many-calls?)
        counter
        (begin (set! counter (+ counter 1))
               (proc arg))))
    call-proc))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
