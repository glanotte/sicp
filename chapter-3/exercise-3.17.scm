(define (count-pairs x)
  (define tmp-lst '())
  (define (count x)
    (if (or (not (pair? x)) (memq x tmp-lst))
      0
      (begin
        (set! tmp-lst (cons x tmp-lst))
        (+ (count (car x))
           (count (cdr x))
           1))))
  (count x))

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
