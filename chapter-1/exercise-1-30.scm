(define (sum term a next b)
  (define (iter a result)
    (newline) (display result)
    (if (> a b)
      result
      (iter (next a) (+ result (term a)))))
  (iter a 0))

(define (inc x) (+ x 1))
(define (sum-int a b) (sum square a inc b))
(sum-int 1 4)
