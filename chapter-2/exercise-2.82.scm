(define (apply-generic op . args)
  (define (find-target types)
    (cond ((null? (cdr types)) #f)
          ((andmap = types) (car types))
          ((andmap (lambda (x) (get-coercion x (car types))) (cdr types)) (car types))
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

