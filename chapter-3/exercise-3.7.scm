(define (make-account balance password)
  (let ((secret password))
    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (set-password password)
      (set! secret password))
    (define (dispatch password m)
      (if (eq? password secret)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'set-password) set-password)
              (else (error "unknown request: MAKE-ACCOUNT"
                           m)))
        (error "Incorrect password")))
    dispatch))

(define (make-joint acc old-password new-password)
  (let ((copy-acc acc))
    ((copy-acc old-password 'set-password) new-password)
    copy-acc))

(define acc (make-account 100 'secret-password))
((acc 'secret-password 'withdraw) 40)
((acc 'wrong-password 'withdraw) 40)
(define paul-acc
  (make-joint acc 'secret-password 'other-password))
(paul-acc 'other-password 'deposit 10)
