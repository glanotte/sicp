(define (all-pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (my-stream-map (lambda (x) (list (stream-car s) x))
                     (stream-cdr t))
      (interleave
        (my-stream-map (lambda (x) (list x (stream-car t)))
                       (stream-cdr s))
        (all-pairs (stream-cdr s) (stream-cdr t))))))

(define new-pairs (all-pairs integers integers))
(display (stream-ref new-pairs 0))
(display (stream-ref new-pairs 1))
(display (stream-ref new-pairs 2))
(display (stream-ref new-pairs 3))
(display (stream-ref new-pairs 4))
(display (stream-ref new-pairs 5))
(display (stream-ref new-pairs 6))
(display (stream-ref new-pairs 7))
(display (stream-ref new-pairs 8))
(display (stream-ref new-pairs 9))
(display (stream-ref new-pairs 10))
(display (stream-ref new-pairs 11))
(display (stream-ref new-pairs 12))

