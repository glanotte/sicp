(define (same-parity n . items)
  (define (iter items)
    (if (null? items)
      items
      (if (= (remainder (car items) 2)
             (remainder n 2))
        (cons (car items)
              (iter (cdr items)))
        (iter (cdr items)))))
  (cons n (iter items)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 5 6 7)
