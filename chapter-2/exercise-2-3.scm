(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (make-segment start end) (cons start end))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (rect-perimeter rect)
  (+ (* 2 (rect-height rect))
     (* 2 (rect-width rect))))

(define (rect-area rect)
  (* (rect-height rect)
     (rect-width rect)))

(define (make-rect left bottom)
  (cons left bottom))

(define (bottom-rect rect) (cdr rect))
(define (left-rect rect) (car rect))

(define (rect-height rect)
  (abs (- (y-point (start-segment (left-rect rect)))
          (y-point (end-segment (left-rect rect))))))

(define (rect-width rect)
  (abs (- (x-point (start-segment (bottom-rect rect)))
          (x-point (end-segment (bottom-rect rect))))))

(define r1 (make-rect
             (make-segment (make-point 4 8 )
                           (make-point 4 16))
             (make-segment (make-point 4 8 )
                           (make-point 20 8 ))))
(rect-area r1)
(rect-perimeter r1)

(define (make-rect bottom-left top-right)
  (cons bottom-left top-right))
(define (bottom-left rect) (car rect))
(define (top-right rect) (cdr rect))

(define (rect-height rect)
  (abs (- (y-point (bottom-left rect))
          (y-point (top-right rect)))))

(define (rect-width rect)
  (abs (- (x-point (bottom-left rect))
          (x-point (top-right rect)))))

(define r2 (make-rect
             (make-point 4 8)
             (make-point 20 16)))

(rect-area r2)
(rect-perimeter r2)
