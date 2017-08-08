(define (my-reverse sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

(define (my-reverse sequence)
  (accumulate (lambda (x y) (append y (list x))) nil sequence))

(my-reverse (list 1 2 3 4))
