(define (has-cycle? x)
  (define temp '())
  (define (iter x)
    (cond ((null? x) #f)
          ((memq x temp) #t)
          (else
            (set! temp (cons x temp))
                (iter (cdr x)))))
  (iter x))
