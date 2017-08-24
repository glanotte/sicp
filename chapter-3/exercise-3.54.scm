(define (mul-streams s1 s2) (my-stream-map * s1 s2))
(define factorials
  (cons-stream 1 (mul-streams integers factorials)))
(stream-ref factorials 4)
