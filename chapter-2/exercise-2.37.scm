(define (accumulate-n op init seqs)
  (if (null? (car seqs))
    nil
    (cons (accumulate op init (map car seqs))
          (accumulate-n op init (map cdr seqs)))))

(define v (list 1 2 3))
(define w (list 1 4 7 10))
(define x (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define y (list (list 1 2 3 4) (list 5 6 7 8) (list 9 10 11 12)))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product v w)

(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(matrix-*-vector x v)

(define (transpose mat)
  (accumulate-n cons nil mat))

(transpose x)

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (matrix-*-vector cols x)) m)))

(matrix-*-matrix x y)
