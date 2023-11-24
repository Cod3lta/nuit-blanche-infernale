extends MyState


@export var fire_state: Node


func trigger(trigger: String):
	match trigger:
		"new_fire":
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_close_door, self)
			# play the closing animation
			
			state_machine.set_state(fire_state)
			return true
	return false

