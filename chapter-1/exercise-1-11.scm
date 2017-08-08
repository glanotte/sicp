(define (f n)
  (cond ((< n 3) n)
        (else (+ (f (- n 1))
                 (* 2 (f (- n 2)))
                 (* 3 (f (- n 3)))))))

(define (fi n)
  (if (< n 3)
    n
    (fi-iter 2 1 0 n)))

(define (fi-iter a b c count)
  (if (< count 3)
    a
    (fi-iter (+ a (* 2 b) (* 3 c))
             a
             b
             (- count 1))))

  ; f1 = 1
  ; f2 = 2
  ; f3 = 2f1 + f2
  ;      4
  ; f4 = 3f1 + 2f2 + 2f1 + f2
  ;      5f1 + 3f2
  ;      11
  ; f5 = 3f2 + 2f3 + f4
  ;      3f2 + 2(2f1 + f2) + 5f1 + 3f2
  ;      9f1 + 8f2
  ;      25
  ; f6 = 3f3 + 2f4 + f5
  ;      3(2f1 + f2) + 2(5f1 + 3f2) + 9f1 + 8f2
  ;      25f1 + 17f2
  ;      59
  ; f7 = 3f4 + 2f5 + f6
  ;      3(5f1 + 3f2) + 2(9f1 + 8f2) + 25f1 + 17f2
  ;      58f1 + 42f2
  ;      142

