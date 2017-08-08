(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (square-tree sub-tree)
           (square sub-tree)))
       tree))

(define (tree-map f tree)
  (map (lambda (subtree)
         (if (pair? subtree)
           (tree-map f subtree)
           (f subtree)))
       tree))

(define (square-tree tree) (tree-map square tree))
(square-tree (list 1 (list 2 (list 3 4) 5) (list 6 7)))
