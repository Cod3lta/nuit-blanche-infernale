extends Node3D

@export_enum("positive", "negative") var open_side: int
@export var open: bool = false:
	set(val): 
		if val:
			$AnimationPlayer.play("opening")
		else:
			$AnimationPlayer.play("closing")

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

