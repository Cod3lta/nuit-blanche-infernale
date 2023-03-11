extends Node


func get_player() -> Player:
	return get_node("/root/Game/Player")

func get_pizza_trigger() -> Node3D:
	return get_node("/root/Game/PizzaTrigger")
