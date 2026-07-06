
(define (domain toy-warehouse-robot-version-3)
  (:types box pos)

  (:predicates
   (on-shelf ?b - box ?p - pos)
   (on-box ?above - box ?below - box)
   (holding ?b - box)
   (empty-gripper)
   (empty-shelf ?p - pos)
   (empty-above ?b - box)
   (next-to ?l - pos ?r - pos)
   ;; robot state:
   (robot-at ?p - pos)
   (lift-is-down)
   (lift-is-up)
   (gripper-folded)
   (gripper-unfolded)
   ;; more derived predicates:
   (clear-sideways ?p - pos)
   (clear-below ?p - pos)
   (clear-left ?p - pos)
   (clear-right ?p - pos)
   )

  ;; Here, the empty-* and clear-* predicates are modelled as derived:

  (:derived (empty-gripper)
  	    (forall (?b - box) (not (holding ?b))))

  (:derived (empty-shelf ?p)
  	    (forall (?b - box) (not (on-shelf ?b ?p))))

  (:derived (empty-above ?b)
  	    (forall (?a - box) (not (on-box ?a ?b))))

  (:derived (clear-sideways ?p)
	    (gripper-folded))
  (:derived (clear-sideways ?p)
	    (empty-shelf ?p))
  (:derived (clear-sideways ?p)
	    (and (lift-is-up)
		 (exists (?b - box) (and (on-shelf ?b ?p)
					 (empty-above ?b)))))

  (:derived (clear-below ?p)
	    (gripper-folded))
  (:derived (clear-below ?p)
	    (empty-gripper))
  (:derived (clear-below ?p)
	    (empty-shelf ?p))

  (:derived (clear-left ?p)
	    (forall (?lp - pos) (not (next-to ?lp ?p))))
  (:derived (clear-left ?p)
	    (exists (?lp - pos) (and (next-to ?lp ?p)
				     (clear-sideways ?lp))))

  (:derived (clear-right ?p)
	    (forall (?rp - pos) (not (next-to ?p ?rp))))
  (:derived (clear-right ?p)
	    (exists (?rp - pos) (and (next-to ?p ?rp)
				     (clear-sideways ?rp))))
  
  (:action take-box-from-shelf
   :parameters (?b - box ?p - pos)
   :precondition (and (on-shelf ?b ?p)
		      (empty-above ?b)
		      (empty-gripper)
		      (robot-at ?p)
		      (lift-is-down)
		      (gripper-unfolded))
   :effect (and (not (on-shelf ?b ?p))
		(holding ?b))
   )

  (:action take-box-from-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (on-box ?b ?bb)
		      (on-shelf ?bb ?p)
		      (empty-above ?b)
		      (empty-gripper)
		      (robot-at ?p)
		      (lift-is-up)
		      (gripper-unfolded))
   :effect (and (not (on-box ?b ?bb))
		(holding ?b))
   )

  (:action put-box-on-shelf
   :parameters (?b - box ?p - pos)
   :precondition (and (holding ?b)
		      (empty-shelf ?p)
		      (robot-at ?p)
		      (lift-is-down)
		      (gripper-unfolded))
   :effect (and (not (holding ?b))
		(on-shelf ?b ?p))
   )

  (:action put-box-on-box
   :parameters (?b - box ?bb - box ?p - pos)
   :precondition (and (holding ?b)
		      (on-shelf ?bb ?p)
		      (empty-above ?bb)
		      (robot-at ?p)
		      (lift-is-up)
		      (gripper-unfolded))		      
   :effect (and (not (holding ?b))
		(on-box ?b ?bb))
   )

  (:action move-left
   :parameters (?p - pos ?np - pos)
   :precondition (and (robot-at ?p)
		      (next-to ?np ?p)
		      (clear-sideways ?np))
   :effect (and (not (robot-at ?p))
		(robot-at ?np))
   )

  (:action move-right
   :parameters (?p - pos ?np - pos)
   :precondition (and (robot-at ?p)
		      (next-to ?p ?np)
		      (clear-sideways ?np))
   :effect (and (not (robot-at ?p))
		(robot-at ?np))
   )

  (:action raise-lift
   :parameters ()
   :precondition (lift-is-down)
   :effect (and (not (lift-is-down))
		(lift-is-up))
   )

  (:action lower-lift
   :parameters (?p - pos)
   :precondition (and (robot-at ?p)
		      (lift-is-up)
		      (clear-below ?p))
   :effect (and (not (lift-is-up))
		(lift-is-down))
   )

  (:action unfold-gripper
   :parameters (?p - pos)
   :precondition (and (robot-at ?p)
		      (gripper-folded)
		      (clear-left ?p)
		      (clear-right ?p))
   :effect (and (not (gripper-folded))
		(gripper-unfolded))
   )

  (:action fold-gripper
   :parameters (?p - pos)
   :precondition (and (robot-at ?p)
		      (gripper-unfolded)
		      (clear-left ?p)
		      (clear-right ?p))
   :effect (and (not (gripper-unfolded))
		(gripper-folded))
   )

  )
