extends Node

var hungry_developers : Array[Developer]
var pizza_ressource = preload("res://objects/pizza/Pizza.tscn")
@onready var pizza_trigger = get_node("/root/Game/PizzaTrigger")


func start_event():
	# Choose a random dev, animate it
	var hungry_possibly_developers = get_tree().get_nodes_in_group("hungry_dev") as Array[Developer]
	hungry_possibly_developers = hungry_possibly_developers.filter(func(dev): return dev not in hungry_developers)
	if hungry_possibly_developers.size() < 1:
		return
	var i = randi_range(0, hungry_possibly_developers.size() - 1)
	var hungry_dev = hungry_possibly_developers[i]
	hungry_dev.start_animation("hungry")
	# Play sound
	
	hungry_developers.push_back(hungry_dev)
	# Add a new pizza in the kitchen
	pizza_trigger.add_pizza()
	$StateMachine.set_trigger("new_hungry_dev")

#called by the hungry state
func hungry() -> void:
	pizza_trigger.connect("get_pizza", get_pizza)
	for dev in hungry_developers:
		dev.disconnect("feed", feed_developer)


func get_pizza() -> void:
	pizza_trigger.remove_pizza()
	Accesser.get_player().hold_node(pizza_ressource.instantiate())
	$StateMachine.set_trigger("get_pizza")


func bring_food() -> void:
	pizza_trigger.disconnect("get_pizza", get_pizza)
	for dev in hungry_developers:
		dev.connect("feed", feed_developer)


func feed_developer(dev: Developer):
	Accesser.get_player().hold_stop()
	dev.stop_animation()
	hungry_developers.erase(dev)
	
	if hungry_developers.size() > 0:
		$StateMachine.set_trigger("still_hungry")
	else:
		$StateMachine.set_trigger("fed_everyone")
