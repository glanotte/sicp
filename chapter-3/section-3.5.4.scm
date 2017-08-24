(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream
      initial-value
      (let ((integrand (force delayed-integrand)))
        (add-streams (scale-stream integrand dt) int))))
  int)

(define (solve f y0 dt)
  (let ((y 'unassigned)
        (dy 'unassigned))
  (set! y (integral (delay dy) y0 dt))
  (set! dy (my-stream-map f y))
  y))

(stream-ref (solve (lambda (y) y)
                   1
                   0.001)
            1000)
