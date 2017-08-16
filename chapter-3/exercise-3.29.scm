(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((not-o1 (make-wire))
          (not-o2 (make-wire))
          (not-o1-and-not-2 (make-wire)))
      (inverter o1 not-o1)
      (inverter o2 not-o2)
      (and-gate not-o1 not-o2 not-o1-and-not-2)
      (inverter not-o1-and-not-2 output)))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)


