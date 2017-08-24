; (define (integral integrand initial-value dt)
;   (cons-stream
;     initial-value
;     (if (stream-null? integrand)
;       the-empty-stream
;       (integral (stream-cdr integral  )
;                 (+ (* dt (stream-car integrand))
;                    initial-value)
;                 dt))))
(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
        the-empty-stream
        (integral (delay (stream-cdr integrand))
                  (+ (* dt (stream-car integrand))
                     initial-value)
                  dt)))))

(define (solve f y0 dt)
  (let ((y 'unassigned)
        (dy 'unassigned))
    (set! y (integral (delay dy) y0 dt))
    (set! dy (my-stream-map f y))
    y))

