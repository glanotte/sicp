(define (put-raise from to f)
(define (install-rational-package)
  (define (tag x) (attach-tag 'rational x))
  (define (int->rat argument)
    (make-rat argument 1))
  (put-raise 'scheme-number 'rational
       (lambda (x) (tag (int->rat x))))
  'done)

(define (install-real-package)
  (define (rat->real argument)
    (/ (numer argument) (denom argument)))
  (define (tag x) (attach-tag 'real x))
  (put-raise 'rational 'real
       (lambda (x) (tag (rat->real x))))
  'done)

(define (install-complex-package)
  (define (real->complex argument)
    (make-complex-from-real-imag argument 0))
  (define (tag x) (attach-tag 'complex x))
  (put-raise 'real 'complex
       (lambda (x) (tag (real->complex x))))
  'done)

(define (apply-generic op . args)
  (define (find-target types)
    (cond ((null? (cdr types)) #f)
          ((andmap = types) (car types))
          ((andmap (lambda (x) (get-raise x (car types))) (cdr types)) (car types))
          (else (find-target (cdr types)))))
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tag)))
      (if proc
        (apply proc (map contents args))
        (let ((target-type (find-target type-tags)))
          (if target-type
            (apply-generic op
                           (map (lambda (x) ((get-coercion (type-tag x) target-type) x))
                                args))
            (error "No method for these types"
                   (list op type-tags))))))))
