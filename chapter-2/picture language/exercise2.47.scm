#lang sicp
(#%require sicp-pict)

(define (list-make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (list-edge2-frame frame)
  (cadr (cdr frame)))

(define (edge2-frame frame)
  (cdr (cdr frame)))

(define f (make-frame 1 2 3))
(newline)
(display "origin: ")
(display (origin-frame f))
(newline)
(display "edge 1: ")
(display (edge1-frame f))
(newline)
(display "edge 2: ")
(display (edge2-frame f))
