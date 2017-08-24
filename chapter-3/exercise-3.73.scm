(define (RC R C dt)
  (lambda (i v0)
    (add-streams
      (scale-stream i R)
      (integral (scale-stream i (/ 1 C)) v0 dt))))

(define RC1 (RC 5 1 0.5))
(display (stream-ref (RC1 integers 0.2) 0))(newline)
(display (stream-ref (RC1 integers 0.2) 1))(newline)
(display (stream-ref (RC1 integers 0.2) 2))(newline)
(display (stream-ref (RC1 integers 0.2) 3))(newline)
