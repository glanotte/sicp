(define (count-pairs x) (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define x3 (list 'a 'b 'c))
(display (count-pairs x3))

(define x1 (list 'a))
(define y1 (cons x1 x1))
(define x4 (list y1))
(display (count-pairs x4))


(define x1 (list 'a))
(define y1 (cons x1 x1))
(define x7 (cons y1 y1))
(display (count-pairs x7))


(define x-inf (cons 'a 'b))
(set-cdr! x-inf x-inf)
(display (count-pairs x-inf))
