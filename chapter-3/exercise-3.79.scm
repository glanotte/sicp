(define (solve-2nd f dt y0 dy0)
  (let ((y 'unassigned)
        (dy 'unassigned)
        (ddy 'unassigned))
    (set! y (integral (delay dy) y0))
    (set! dy (integral (delay ddy) dy0))
    (set! ddy (my-stream-map f y dy))
    y))


