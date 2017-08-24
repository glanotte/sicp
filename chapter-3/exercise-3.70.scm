(define (weighted-merge s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (cond ((< (weight s1car) (weight s2car))
                   (cons-stream
                     s1car
                     (weighted-merge (stream-cdr s1) s2 weight)))
                  ((> (weight s1car) (weight s2car))
                   (cons-stream
                     s2car
                     (weighted-merge s1 (stream-cdr s2) weight)))
                  (else
                    (cons-stream
                      s1car
                      (weighted-merge (stream-cdr s1) s2 weight))))))))

(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (weighted-merge
      (my-stream-map (lambda (x) (list (stream-car s) x))
                     (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define sum-int (weighted-pairs integers integers (lambda (pair) (+ (car pair) (cadr pair)))))
; (display (stream-ref sum-int 0))
; (display (stream-ref sum-int 1))
; (display (stream-ref sum-int 2))
; (display (stream-ref sum-int 3))
; (display (stream-ref sum-int 4))
; (display (stream-ref sum-int 5))
; (display (stream-ref sum-int 6))

(define stream-235 (my-stream-filter (lambda (x) (not (or (= 0 (remainder x 2))
                                                          (= 0 (remainder x 3))
                                                          (= 0 (remainder x 5)))))
                                     integers))

(define weight-ints-2 (weighted-pairs stream-235
                                      stream-235
                                      (lambda (pair) (+ (* 2 (car pair))
                                                        (* 3 (cadr pair))
                                                        (* 5 (car pair) (cadr pair))))))
