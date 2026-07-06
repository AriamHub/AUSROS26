
(define (domain toy-warehouse-robot-version-1)
  (:types box pos)

  (:predicates
   (on-shelf ?b - box ?p - pos)
   (on-box ?above - box ?below - box)
   (holding ?b - box)
   )

  (:action take-box-from-shelf
   :parameters (?b - box ?p - pos)
   :precondition (on-shelf ?b ?p)
   :effect (and (not (on-shelf ?b ?p))
		(holding ?b))
   )

  (:action take-box-from-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (on-box ?b ?bb)
		      (on-shelf ?bb ?p))
   :effect (and (not (on-box ?b ?bb))
		(holding ?b))
   )

  (:action put-box-on-shelf
   :parameters (?b - box ?p - pos)
   :precondition (holding ?b)
   :effect (and (not (holding ?b))
		(on-shelf ?b ?p))
   )

  (:action put-box-on-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (holding ?b)
		      (on-shelf ?bb ?p))
   :effect (and (not (holding ?b))
		(on-box ?b ?bb))
   )
  
  )
