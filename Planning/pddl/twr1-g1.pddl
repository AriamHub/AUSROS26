
(define (problem test-goal-1)
  (:domain toy-warehouse-robot-version-1)
  (:objects
   blue red green - box
   centre left right - pos
   )
  (:init
   (on-shelf green left)
   (on-shelf red centre)
   (on-shelf blue right)
   )
  (:goal (on-box green blue))
  )

;; (:plan
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green blue right)
;;  )
