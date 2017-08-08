(define (equal? x y)
  (cond ((and (null? x) (null? y)) true)
        ((and (pair? x) (pair? y))
         (and (eq? (car x) (car y)) (equal? (cdr x) (cdr y))))
        (else false)))

(equal? '(this is a list) '(this (is a) list))
(equal? '(this is a list) '(this is a list))

