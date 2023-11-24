extends MyState


@export var broken_state: Node


func enter() -> void:
	pass


func trigger(trigger: String) -> bool:
	match trigger:
		"break":
			state_machine.set_state(broken_state)
			return true
	return false

