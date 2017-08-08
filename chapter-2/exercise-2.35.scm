(define (old-count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (my-count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))

(my-count-leaves (list 1 (list 1 2 (list 3 4) 5)))
