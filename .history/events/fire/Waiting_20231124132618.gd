extends MyState


@export var fire_state: Node


func trigger(trigger: String):
	match trigger:
		"new_fire":
			state_machine.set_state(fire_state)
			return true
	return false

