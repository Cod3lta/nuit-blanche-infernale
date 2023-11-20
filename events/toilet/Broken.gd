extends MyState


@export var waiting_state: Node


func trigger(trigger: String):
	match trigger:
		"repair":
			
			# then go the "closed" state
			state_machine.set_state(waiting_state)
