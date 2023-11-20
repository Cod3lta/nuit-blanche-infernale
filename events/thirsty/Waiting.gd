extends MyState


@export var broken_state: Node


func trigger(trigger: String):
	match trigger:
		"break":
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_close_door, self)
			# play the closing animation
			
			# then go the "closed" state
			state_machine.set_state(broken_state)

