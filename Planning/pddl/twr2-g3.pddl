
(define (problem test-goal-3)
  (:domain toy-warehouse-robot-version-2)
  (:objects
   blue red green - box
   centre left right - pos
   )
  (:init
   (on-shelf green left)
   (on-shelf red centre)
   (on-shelf blue right)
   (empty-gripper)
   (empty-above green)
   (empty-above red)
   (empty-above blue)
   )
  (:goal (and
	  (on-shelf blue left)
	  (on-box green blue)
	  (on-shelf red centre)
	  ))
  )

;; (:plan
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green red centre)
;;  (take-box-from-shelf blue right)
;;  (put-box-on-shelf blue left)
;;  (take-box-from-box green red centre)
;;  (put-box-on-box green blue left)
;;  )
