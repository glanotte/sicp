(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?address))

(and (salary ?person ?amount)
     (salary (Bitdiddle Ben) ?ben-salary)
     (lisp-value < ?ben-salary ?amount))

(and (not (job ?supervisor-name (computer . ?type)))
     (supervisor ?person ?supervisor-name)
     (job ?supervisor ?supervisor-job))
