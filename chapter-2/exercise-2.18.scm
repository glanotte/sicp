(define (last-pair items)
  (list-ref items (- (length items) 1)))
(define (reverse items)
  (define (iter i)
    (if (= i 0)
      (list (car items))
      (cons (list-ref items i)
            (iter (- i 1)))))
  (iter (- (length items) 1)))


(reverse (list 1 2 3 4 5))

