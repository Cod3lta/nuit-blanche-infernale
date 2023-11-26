extends MyState

@export var door: Node3D
@export var animation_player: AnimationPlayer
@export var closed_state: Node


func enter() -> void:
	pass


func exit() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"closing":
			animation_player.play(get_door_animation())
			state_machine.change_state(closed_state)


func get_door_animation():
	if door.opening_side == door.opening_sides.POSITIVE:
		return "closing_positive"
	elif door.opening_side == door.opening_sides.NEGATIVE:
		return "closing_negative"
