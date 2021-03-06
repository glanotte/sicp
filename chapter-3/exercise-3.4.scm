
(define (make-account balance password)
  (let ((secret password)
        (consecutive-fails 0))
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (call-the-cops)
      (error "we have called the police"))
    (define (incorrect-password)
      (set! consecutive-fails (+ consecutive-fails 1))
      (if (>= consecutive-fails 7)
        (call-the-cops)
        (error "Incorrect password")))
    (define (correct-password m)
      (set! consecutive-fails 0)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "unknown request: MAKE-ACCOUNT"
                         m))))
    (define (dispatch password m)
      (if (eq? password secret)
        (correct-password m)
        (incorrect-password)))
    dispatch))

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
