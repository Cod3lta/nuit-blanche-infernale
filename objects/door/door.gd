extends Node3D

@export_enum("POSITIVE", "NEGATIVE") var open_side: int
@export var open: bool:
	set(val): 
		# C'est dégeulasse mais bon hein ok
		if val:
			if open_side == 0:
				$AnimationPlayer.play("opening_positive")
			else: 
				$AnimationPlayer.play("opening_negative")
		else:
			if open_side == 0:
				$AnimationPlayer.play("closing_positive")
			else: 
				$AnimationPlayer.play("closing_negative")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_state_machine_player_transited(from, to):
	match to:
		"opening":
			open = true
		"closing":
			open = false
	

func on_close():
	$StateMachinePlayer.set_trigger("closed")


func on_open():
	$StateMachinePlayer.set_trigger("opened")


func _on_area_3d_player_entered(body):
	$StateMachinePlayer.set_trigger("open")


func _on_area_3d_player_exited(body):
	$StateMachinePlayer.set_trigger("close")

