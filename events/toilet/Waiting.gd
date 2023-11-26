extends MyState


@export var broken_state: Node


func enter() -> void:
	pass


func exit() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"break":
			state_machine.change_state(broken_state)
			return true
	return false

