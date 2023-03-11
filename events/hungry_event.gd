extends Event

@export var hungry_dev : Developer
@export var pizza_trigger : int


func start() -> void:
	# Get the pizza_trigger and connect a signal to a function here
	Accesser.get_pizza_trigger().connect("get_pizza", get_pizza)
	
	var hungry_dev: Developer = choose_random_dev()
	hungry_dev.animate("hungry")


func choose_random_dev() -> Node:
	var possibly_hungry_developers: Array[Node] = get_tree().get_nodes_in_group("hungry_dev")
	var i = randi_range(0, possibly_hungry_developers.size() - 1)
	return possibly_hungry_developers[i]


func get_pizza() -> void:
	get_node("/root/Game/PizzaTrigger").disconnect("get_pizza", get_pizza)
	print("Got pizza!")
	$StateMachinePlayer.set_trigger("get_pizza")


func _on_state_machine_player_transited(from, to):
	match to:
		"hungry":
			print("now hungry")
		"bring_food":
			print("now bringing food")
