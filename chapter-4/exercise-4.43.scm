(define (yachts)
  (define (require p) (if (not p) (amb)))
  (let ((maryann 'moore)
        (lorna (amb 'hall 'downing))
        (gabrielle 'parker)
        (melissa 'barnacle)
        (rosalind (amb 'downing)))))
