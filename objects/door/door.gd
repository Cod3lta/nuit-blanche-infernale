extends Node3D

enum opening_sides {POSITIVE, NEGATIVE}

@export var opening_side: opening_sides


func _on_area_3d_player_entered(body):
	$StateMachine.trigger("opening")


func _on_area_3d_player_exited(body):
	$StateMachine.trigger("closing")
