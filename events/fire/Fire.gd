extends MyState


@export var can_extinguish_state: Node


func trigger(trigger: String):
	match trigger:
		"get_extinctor":
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_close_door, self)
			# play the closing animation
			
			state_machine.set_state(can_extinguish_state)

