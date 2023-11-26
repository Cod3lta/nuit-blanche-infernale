extends MyState


@export var waiting_state: Node


func enter() -> void:
	pass


func exit() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"repair":
			state_machine.change_state(waiting_state)
			return true
	return false
