extends MyState

@export var door: Node3D
@export var animation_player: AnimationPlayer
@export var opened_state: Node


func enter() -> void:
	pass


func exit() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"opening":
			animation_player.play(get_door_animation())
			state_machine.change_state(opened_state)


func get_door_animation():
	if door.opening_side == door.opening_sides.POSITIVE:
		return "opening_positive"
	elif door.opening_side == door.opening_sides.NEGATIVE:
		return "opening_negative"
