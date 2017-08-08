(define (reverse items)
  (if (null? items)
    items
    (append (reverse (cdr items)) (list (car items)))))

(reverse (list 1 2 3 4))
(reverse (list (list 1 2) 3 4))
(reverse (list (list 1 2) (list 3 4)))

(define (deep-reverse items)
  (cond ((null? items) items)
        ((pair? (car items))
         (append (deep-reverse (cdr items))
                 (list (deep-reverse (car items)))))
        (else
          (append (deep-reverse (cdr items))
                  (list (car items))))))


(deep-reverse (list 1 2 3 4))
(deep-reverse (list (list 1 2) 3 4))
(deep-reverse (list (list 1 2) (list 3 4)))
