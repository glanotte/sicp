(define (find-ordered-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- n 2))))
                      (enumerate-interval 1 (- n 2))))
           (enumerate-interval 1 (- n 2))))

(define (find-sum-triples n)
  (my-filter (lambda (x) (= n (accumulate + 0 x)))
             (find-ordered-triples n)))

(find-sum-triples 6)
