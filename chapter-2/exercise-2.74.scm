;a

(define (get-record division name)
  ((get division 'record) name))

; b

(define (get-salary division record)
  ((get division 'salary) record))

; c

(define (find-employee-record name divisions)
  (if (null? divisions)
    #f
    (let (rec (get-record (car divisions) name))
      (if (null? rec)
        (find-employee-record name (cdr divisions))
        rec))))
