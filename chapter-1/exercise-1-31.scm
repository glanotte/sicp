; (define (product term a next b)
;   (if (> a b)
;     1
;     (* (term a) (product term (next a) next b))))
; (define (square x) (* x x))
; (define (inc x) (+ x 1))
(define (product term a next b)
  (define (iter a result)
    (if (> a b)
      result
      (iter (next a) (* result (term a)))))
  (iter a 1))
(define (square x) (* x x))
(define (inc x) (+ x 1))

(define (find-pi until)
  (define (inc-2 x) (+ x 2))
  (define (pi-term x)
    (/ (square x) (* (- x 1) (+ x 1))))
  (/ (* 8.0 (product pi-term 4.0 inc-2 until)) 3))

(find-pi 10000000)
; (define (prod-square a b)
;   (product square a inc b))

; (prod-square 2 4)
