extends MyState


@export var hungry_state: Node


func enter() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"new_hungry_dev":
			state_machine.set_state(hungry_state)
			return true
	return false
