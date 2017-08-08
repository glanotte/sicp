(define (filtered-accumulate predicate combiner null-value term a next b)
  (newline) (display a) (display ": ") (display (predicate a))
  (cond ((predicate a)
         (combiner (term a) (filtered-accumulate predicate combiner null-value term (next a) next b)))
        ((> a b) null-value)
        (else
          (combiner null-value (filtered-accumulate predicate combiner null-value term (next a) next b)))))


(define (filtered-sum predicate term a next b)
  (filtered-accumulate predicate + 0 term a next b))

(define (inc x) (+ x 1))

(define (sum-prime-sq a b) (filtered-sum prime? square a inc b))
(sum-prime-sq 3 8)
