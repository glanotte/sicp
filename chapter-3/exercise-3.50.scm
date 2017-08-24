(define (my-stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply my-stream-map
             (cons proc (map stream-cdr argstreams))))))
(define int1 (stream-enumerate-interval 1 100))
(define int2 (stream-enumerate-interval 101 200))
(define x (my-stream-map + int1 int2))
