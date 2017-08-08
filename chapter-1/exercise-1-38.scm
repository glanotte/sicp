(define (cont-frac n d k)
  (define (frac i result)
    (if (= i 0)
      result
      (frac (- i 1) (/ (n i) (+ (d i) result)))))
  (frac k 0))

(define (d i)
  (cond ((= i 1) 1.0)
        ((= (remainder (+ i 1) 3) 0) (* (/ (+ i 1) 3) 2))
        (else 1.0)))

(cont-frac (lambda (i) 1.0)
           d
           10)
