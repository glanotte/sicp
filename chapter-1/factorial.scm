(define (factorial n)
  (if (= n 1)
    1
    (* n (factorial (- n 1)))))

(define (factorial n)
  (define (iter product counter max-count)
    (if (> counter max-count)
      product
      (iter (* counter product)
            (+ counter 1)
            max-count)))
  (iter 1 1 n))
