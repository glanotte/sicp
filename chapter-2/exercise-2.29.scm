(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define left-branch car)
(define right-branch cdr)
(define branch-length car)
(define branch-structure cdr)


(define branch (make-branch 4 (make-branch 2 4)))
(branch-weight branch)

(define (branch-weight branch)
  (cond ((null? branch) 0)
        ((pair? (branch-structure branch))
         (total-weight (branch-structure branch)))
        (else (branch-structure branch))))

(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (balanced? mobile)
  (define (torque branch)
    (* (branch-length branch) (branch-weight branch)))
    (newline)
    (display "left: ")
    (display (torque (left-branch mobile)))
    (newline)
    (display "right: ")
    (display (torque (right-branch mobile)))
  (define (torque-balanced? mobile)
    (= (torque (left-branch mobile))
       (torque (right-branch mobile))))
  (define (branch-balanced? branch)
    (cond ((pair? (branch-structure branch))
           (balanced? (branch-structure branch)))
          (else #t)))
  (define (children-balanced? mobile)
    (and (branch-balanced? (left-branch mobile))
         (branch-balanced? (right-branch mobile))))
  (and (children-balanced? mobile) (torque-balanced? mobile)))


(define mob (make-mobile (make-branch 4 3)
                         (make-branch 1 12)))
(define mobile (make-mobile (make-branch 3 mob)
                            (make-branch 5 9)))

  (total-weight mobile)


