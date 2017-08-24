(define (show x)
  (display-line x)
  x)
(define x
  (my-stream-map show
                 (stream-enumerate-interval 0 10)))
(stream-ref x 5)
(stream-ref x 7)
