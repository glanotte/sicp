(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (let ((d (* c (/ p 100.0))))
    (make-center-width c d)))

(define (percent i)
  (* (/ (width i) (center i)) 100.0))

(define a (make-center-percent 100 .15))
(define b (make-center-percent 100 .14))
(define c (mul-interval a b))
(percent c)
