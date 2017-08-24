(define sum 0)
(define (accum x) (set! sum (+ x sum)) sum)
(define seq
  (my-stream-map accum
              (stream-enumerate-interval 1 20)))
(define y (my-stream-filter even? seq))
(define z
  (my-stream-filter (lambda (x) (= (remainder x 5) 0))
                    seq))
(display "haaay")
(newline)
; (stream-ref y 7)
(display "yall")
(newline)
(display-stream z)

