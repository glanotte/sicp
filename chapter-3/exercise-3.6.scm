(define random-init 0)
(define (rand-update n) (+ n 1))
(define rand
  (let ((x random-init))
    (define (dispatch sym)
      (cond ((eq? sym 'generate)
             (begin
               (set! x (rand-update x))
               x))
            ((eq? sym 'reset)
             (lambda (new-value)
               (set! x new-value)))
            (else (error "unknown message RAND"
                         sym))))
    dispatch))

(rand 'generate)
(rand 'generate)
(rand 'generate)
((rand 'reset) 10)
(rand 'generate)
