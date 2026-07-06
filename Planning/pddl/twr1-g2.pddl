
(define (problem test-goal-2)
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
  (:goal (and
	  (on-box green blue)
	  (on-shelf blue centre)
	  ))
  )

;; (:plan
;;  (take-box-from-shelf blue right)
;;  (put-box-on-shelf blue centre)
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green blue centre)
;;  )

;; (:plan
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green blue right)
;;  (take-box-from-shelf blue right)
;;  (put-box-on-shelf blue centre)
;;  )

;; (:plan
;;  (take-box-from-shelf blue right)
;;  (take-box-from-shelf green left)
;;  (put-box-on-shelf blue centre)
;;  (put-box-on-box green blue centre)
;;  )
