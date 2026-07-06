
(define (domain cassini-MIR)
  (:types point component liquid - object
	  pyro latch - valve
	  tank valve - component
	  engine - point)

  (:constants he propa propb - liquid)

  (:predicates
   (open ?v - valve)
   (closed ?v - valve)
   (operable ?v - valve)
   (entry_point ?c - component ?p - point)
   (exit_point ?c - component ?p - point)
   (contains ?t - tank ?l - liquid)
   (pressurised ?t - tank)
   (have-thrust)
   (flow ?p - point ?l - liquid)
   )

  ;; The (total-cost) function is used to model the objective of
  ;; avoiding unnecessary use of pyro valves
  (:functions (total-cost))

  ;; The flow relation is calculated using axioms:
  (:derived (flow ?p ?l)
	    (exists (?t - tank)
		    (and (exit_point ?t ?p)
			 (contains ?t ?l)
			 (pressurised ?t))))

  (:derived (flow ?p ?l)
	    (exists (?t - tank ?q - point ?d - liquid)
		    (and (entry_point ?t ?q)
			 (flow ?q ?d)
			 (exit_point ?t ?p)
			 (contains ?t ?l))))

  (:derived (flow ?p ?l)
	    (exists (?v - valve ?q - point)
		    (and (entry_point ?v ?q)
			 (flow ?q ?l)
			 (exit_point ?v ?p)
			 (open ?v))))

  ;; Actions opening/closing a latch valve have cost 1
  (:action open-latch-valve
   :parameters (?v - latch)
   :precondition (and (closed ?v) (operable ?v))
   :effect (and (not (closed ?v))
		(open ?v)
		(increase (total-cost) 1))
   )

  (:action close-latch-valve
   :parameters (?v - latch)
   :precondition (and (open ?v) (operable ?v))
   :effect (and (not (open ?v))
		(closed ?v)
		(increase (total-cost) 1))
   )

  ;; Actions opening/closing a pyro valve have cost 100
  (:action open-pyro-valve
   :parameters (?v - pyro)
   :precondition (and (closed ?v) (operable ?v))
   :effect (and (not (closed ?v))
		(not (operable ?v))
		(open ?v)
		(increase (total-cost) 100))
   )

  (:action close-pyro-valve
   :parameters (?v - pyro)
   :precondition (and (open ?v) (operable ?v))
   :effect (and (not (open ?v))
		(not (operable ?v))
		(closed ?v)
		(increase (total-cost) 100))
   )

  ;; The fire-engine action is used to "record" that thrust was achieved
  (:action fire-engine
   :parameters (?e - engine)
   :precondition (and (flow ?e propa) (flow ?e propb))
   :effect (and (have-thrust)
		(increase (total-cost) 0))
   )

  )
