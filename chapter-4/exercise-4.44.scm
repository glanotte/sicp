(define (queens board-size)
  (define (enumerate-interval low high)
    (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))
  (define (require p) (if (not p) (amb)))
  (define (an-element-of items)
    (require (not (null? items)))
    (amb (car items) (an-element-of (cdr items))))
  (define (queens-cols k)
    (if (= k 0)
      (list empty-board)
      (map
        (lambda (rest-of-queens)
          (let ((new-row (adjoin-position (an-element-of (enumerate-interval 1 board-size))
                                          rest-of-queens)))
            (require (safe? new-row))
            new-row))
        (queens-cols (- k 1)))))
  (queens-cols board-size))

(define empty-board nil)

(define (adjoin-position row col positions)
  (append positions (list (make-position row col))))

(define (make-position row col)
  (cons row col))

(define (position-row position)
  (car position))

(define (position-col position)
  (cdr position))

(define (safe? col positions)
  (let ((kth-queen (list-ref positions (- col 1)))
        (other-queens (my-filter (lambda (q)
                                   (not (= col (position-col q))))
                                 positions)))
    (define (attacks? q1 q2)
      (or (= (position-row q1) (position-row q2))
          (= (abs (- (position-row q1) (position-row q2)))
             (abs (- (position-col q1) (position-col q2))))))

    (define (iter q board)
      (or (null? board)
          (and (not (attacks? q (car board)))
               (iter q (cdr board)))))
    (iter kth-queen other-queens)))
