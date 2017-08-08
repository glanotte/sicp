(define a 1)
(define b 2)
(list a b)
(list 'a 'b)
(list 'a b)


(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

(memq 'apple '(pear banana prune))

(memq 'apple '(x (apple sauce) u apple pear banana prune))

