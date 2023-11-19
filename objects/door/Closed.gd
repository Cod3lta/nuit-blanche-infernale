extends MyState

@export var door: Node3D
@export var animation_player: AnimationPlayer
@export var opened_state: Node


func trigger(trigger: String):
	match trigger:
		"opening":
			# Start the transition
			start_transition()
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_open_door, self)
			# play the opening animation
			animation_player.play(get_door_animation())
			
			# then go the "opened" state
			state_machine.set_state(opened_state)

func get_door_animation():
	if door.opening_side == door.opening_sides.POSITIVE:
		return "opening_positive"
	elif door.opening_side == door.opening_sides.NEGATIVE:
		return "opening_negative"
