(define (generated-hufffman-tree pairs)
    (successive-merge (make-leaf-set pairs)))

(define (successive-merge leaf-set)
  (cond ((null? leaf-set) '())
        ((null? (cdr leaf-set)) (car leaf-set))
        (else (successive-merge
                 (adjoin-set (make-code-tree (car leaf-set)
                                             (cadr leaf-set))
                             (cddr leaf-set))))))



(define sample-pairs (list (list 'A 4)
                           (list 'B 2)
                           (list 'C 1)
                           (list 'D 1)))
