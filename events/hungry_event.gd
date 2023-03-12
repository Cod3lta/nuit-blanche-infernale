extends Node

var hungry_devs : Array[Developer]
var pizza_ressource = preload("res://objects/pizza/Pizza.tscn")

func _ready():
	pass

func waiting():
	pass

func new_developer_hungry():
	# Choose a random dev
	var possibly_hungry_devs: Array[Node] = get_tree().get_nodes_in_group("hungry_dev")
	possibly_hungry_devs = possibly_hungry_devs.filter(func(dev): return dev not in hungry_devs)
	if possibly_hungry_devs.size() < 1:
		return
	var hungry_dev
	var i = randi_range(0, possibly_hungry_devs.size() - 1)
	hungry_dev = possibly_hungry_devs[i]
	hungry_dev.start_animation("hungry")
	hungry_devs.push_back(hungry_dev)
	# Add a new pizza in the kitchen
	Accesser.get_pizza_trigger().add_pizza()
	
	$StateMachinePlayer.set_trigger("new_developer_hungry")


func hungry() -> void:
	Accesser.get_pizza_trigger().connect("get_pizza", get_pizza)
	for dev in hungry_devs:
		dev.disconnect("feed", feed_developer)


func get_pizza() -> void:
	Accesser.get_pizza_trigger().remove_pizza()
	Accesser.get_player().hold_node(pizza_ressource.instantiate())
	$StateMachinePlayer.set_trigger("get_pizza")


func bring_food() -> void:
	Accesser.get_pizza_trigger().disconnect("get_pizza", get_pizza)
	for dev in hungry_devs:
		dev.connect("feed", feed_developer)


func feed_developer(dev: Developer):
	Accesser.get_player().hold_stop()
	dev.stop_animation()
	hungry_devs.erase(dev)
	if hungry_devs.size() > 0:
		$StateMachinePlayer.set_trigger("still_hungry")
	else:
		$StateMachinePlayer.set_trigger("fed_all_developers")


func _on_state_machine_player_transited(from, to):
	match to:
		"waiting":
			waiting()
		"hungry":
			hungry()
		"bring_food":
			bring_food()


func _on_event_timer_timeout():
	new_developer_hungry()
