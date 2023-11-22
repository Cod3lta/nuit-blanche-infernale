extends MyState


@export var waiting_state: Node


func trigger(trigger: String):
	match trigger:
		"repair":
			state_machine.set_state(waiting_state)
			return true
	return false
