extends Node3D

@export var event_open_door: EventAsset
@export var event_close_door: EventAsset
@export_enum("POSITIVE", "NEGATIVE") var open_side: int
@export var open: bool:
	set(val): 
		# C'est dégeulasse mais bon hein ok
		if val:
			# Play sound
			RuntimeManager.play_one_shot_attached(event_open_door, self)
			if open_side == 0:
				$AnimationPlayer.play("opening_positive")
			else: 
				$AnimationPlayer.play("opening_negative")
		else:
			if open_side == 0:
				$AnimationPlayer.play("closing_positive")
			else: 
				$AnimationPlayer.play("closing_negative")


func _on_state_machine_player_transited(from, to):
	match to:
		"opening":
			open = true
		"closing":
			open = false
	

func on_close():
	$StateMachinePlayer.set_trigger("closed")
	# Play sound
	RuntimeManager.play_one_shot_attached(event_close_door, self)


func on_open():
	$StateMachinePlayer.set_trigger("opened")


func _on_area_3d_player_entered(body):
	$StateMachinePlayer.set_trigger("open")


func _on_area_3d_player_exited(body):
	$StateMachinePlayer.set_trigger("close")

