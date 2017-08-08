(define (install-rational-package)
  (define (tag x) (attach-tag 'rational x))
  (define (int->rat argument)
    (make-rat argument 1))
  (put 'raise '(rational)
       (lambda (x) (tag (int->rat x))))
  'done)

(define (install-real-package)
  (define (rat->real argument)
    (/ (numer argument) (denom argument)))
  (define (tag x) (attach-tag 'real x))
  (put 'raise '(rational)
       (lambda (x) (tag (rat->real x))))
  'done)

(define (install-complex-package)
  (define (real->complex argument)
    (make-complex-from-real-imag argument 0))
  (define (tag x) (attach-tag 'complex x))
  (put 'raise '(rational)
       (lambda (x) (tag (real->complex x))))
  'done)



