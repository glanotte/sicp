(define (cube x) (* x x x))
(define (raman-weight x)
  (+ (cube (car x))  (cube (cadr x))))
(define sum-cubes (weighted-pairs integers integers raman-weight))
(define (raman x)
  (let ((this-weight (raman-weight (stream-car x)))
        (next-weight (raman-weight (stream-car (stream-cdr x)))))
    (cond ((eq? this-weight next-weight)
           (cons-stream this-weight (raman (stream-cdr x))))
          (else (raman (stream-cdr x))))))

(define int-raman (raman sum-cubes))
(display (stream-ref int-raman 0))(newline)
(display (stream-ref int-raman 1))(newline)
(display (stream-ref int-raman 2))(newline)
(display (stream-ref int-raman 3))(newline)
(display (stream-ref int-raman 4))(newline)
(display (stream-ref int-raman 5))(newline)
