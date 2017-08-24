(define (solve-2nd a b dt y0 dy0)
  (let ((y 'unassigned)
        (dy 'unassigned)
        (ddy 'unassigned))
    (set! y (integral (delay dy) y0))
    (set! dy (integral (delay ddy) dy0))
    (set! ddy (add-streams (scale-stream dy a)
                           (scale-stream y b)))
    y))


