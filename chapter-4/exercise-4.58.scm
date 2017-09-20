(meeting accounting (Monday 9am))
(meeting administration (Monday 10am))
(meeting computer (Wednesday 3pm))
(meeting administration (Friday 1pm))
(meeting whole-company (Wednesday 4pm))

;;a
(meeting ?who (Friday ?time))

;;b
(rule (meeting-time ?person ?day-and-time)
      (job ?person (?dept . ?job-type))
      (or (meeting whole-company ?day-and-time)
          (meeting ?dept ?day-and-time)))

;;c
(meeting-time ((Hacker Alyssa P) (Wednesday ?time)))
