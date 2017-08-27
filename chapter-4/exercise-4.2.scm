(define (application? expr) (tagged-list? expr 'call))
(define (operator expr) (cadr expr))
(define (operands expr) (cddr expr))
(define (no-operands? ops) (null? (operands ops)))

