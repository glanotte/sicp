(define (square-list items)
  (define (iter things answer)
    (newline) (display things) (display " : ") (display answer)
    (if (null? things)
      answer
      (iter (cdr things)
            (cons (square (car things))
                  answer))))
  (iter items (list)))

(square-list (list 1 2 3 4 5))
