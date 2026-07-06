
(define (problem test-goal-2)
  (:domain toy-warehouse-robot-version-2)
  (:objects
   blue red green - box
   centre left right - pos
   )
  (:init
   (on-shelf green left)
   (on-shelf red centre)
   (on-shelf blue right)
   (empty-above green)
   (empty-above red)
   (empty-above blue)
   (empty-gripper)
   )
  (:goal (and (on-shelf blue centre)
	      (on-box green blue)))
  )

;; (:plan
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green blue right)
;;  (take-box-from-shelf blue right)
;;  (put-box-on-shelf blue centre)
;;  )

;; (:plan
;;  (take-box-from-shelf blue right)
;;  (put-box-on-box blue green left)
;;  (take-box-from-shelf red centre)
;;  (put-box-on-shelf red right)
;;  (take-box-from-box blue green left)
;;  (put-box-on-shelf blue centre)
;;  (take-box-from-shelf green left)
;;  (put-box-on-box green blue centre)
;;  )
