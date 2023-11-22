extends MyState


@export var hungry_state: Node


func trigger(trigger: String):
	match trigger:
		"new_hungry_dev":
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_close_door, self)
			
			state_machine.set_state(hungry_state)
			return true
	return false
