extends MyState


@export var fire_state: Node


func enter() -> void:
	pass


func exit() -> void:
	pass


func trigger(trigger: String) -> bool:
	match trigger:
		"new_fire":
			state_machine.change_state(fire_state)
			return true
	return false

