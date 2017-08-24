(define (triples s t u)
  (cons-stream
    (list (stream-car s) (stream-car t) (stream-car u))
    (interleave
      (my-stream-map (lambda (x) (cons (stream-car s) x))
                     (stream-cdr (pairs t u)))
      (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))))
(define int-trips (triples integers integers integers))
(define (square x) (* x x))
(define pythag
  (my-stream-filter
    (lambda (trips) (eq? (+ (square (car trips))
                            (square (cadr trips)))
                         (square (caddr trips))))
    int-trips))

(display (stream-ref pythag 0))
(display (stream-ref pythag 1))
(display (stream-ref pythag 2))
(display (stream-ref pythag 3))
(display (stream-ref pythag 4))
