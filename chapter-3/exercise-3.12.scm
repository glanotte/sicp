(define (append! a b) (set-cdr! (last-pair a) b) a)
(define (last-pair q) (if (null? (cdr q)) q (last-pair (cdr q))))
