(define (div-interval x y)
  (if (zero-interval? y)
    (error "bad things")
    (mul-interval
      x
      (make-interval (/ 1.0 (upper-bound y))
                     (/ 1.0 (lower-bound y))))))
(define (zero-interval? x)
  (= (- (upper-bound x) (lower-bound x)) 0))

(div-interval (make-interval 1 3)
              (make-interval 3 3))


