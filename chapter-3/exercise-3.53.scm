(define s (cons-stream 1 (add-streams s s)))
(stream-ref s 1)
(stream-ref s 2)
(stream-ref s 3)
