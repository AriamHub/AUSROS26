
(define (domain toy-warehouse-robot-version-2)
  (:types box pos)

  (:predicates
   (on-shelf ?b - box ?p - pos)
   (on-box ?above - box ?below - box)
   (holding ?b - box)
   (empty-gripper)
   (empty-shelf ?p - pos)
   (empty-above ?b - box)
   )

  ;; The predicates empty-gripper, empty-shelf and empty-above are
  ;; functionally determined by the other three predicates, which
  ;; can be modelled using the "derived predicates" feature of PDDL.

  ;; (:derived (empty-gripper)
  ;; 	    (forall (?b - box) (not (holding ?b))))
  ;;
  ;; (:derived (empty-shelf ?p)
  ;; 	    (forall (?b - box) (not (on-shelf ?b ?p))))
  ;;
  ;; (:derived (empty-above ?b)
  ;; 	    (forall (?a - box) (not (on-box ?a ?b))))

  ;; However, the action definitions below instead update these
  ;; predicates explicitly.

  (:action take-box-from-shelf
   :parameters (?b - box ?p - pos)
   :precondition (and (on-shelf ?b ?p)
		      (empty-above ?b)
		      (empty-gripper))
   :effect (and (not (on-shelf ?b ?p))
		(holding ?b)
		(not (empty-gripper))
		(empty-shelf ?p))
   )

  (:action take-box-from-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (on-box ?b ?bb)
		      (on-shelf ?bb ?p)
		      (empty-above ?b)
		      (empty-gripper))
   :effect (and (not (on-box ?b ?bb))
		(holding ?b)
		(not (empty-gripper))
		(empty-above ?bb))
   )

  (:action put-box-on-shelf
   :parameters (?b - box ?p - pos)
   :precondition (and (holding ?b)
		      (empty-shelf ?p))
   :effect (and (not (holding ?b))
		(on-shelf ?b ?p)
		(not (empty-shelf ?p))
		(empty-gripper))
   )

  (:action put-box-on-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (holding ?b)
		      (on-shelf ?bb ?p)
		      (empty-above ?bb))
   :effect (and (not (holding ?b))
		(on-box ?b ?bb)
		(not (empty-above ?bb))
		(empty-gripper))
   )
  
  )
