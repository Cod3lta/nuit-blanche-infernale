extends Node

var hungry_dev : Developer
var pizza_ressource = preload("res://objects/pizza/Pizza.tscn")

func hungry() -> void:
	# Get the pizza_trigger and connect a signal to a function here
	Accesser.get_pizza_trigger().connect("get_pizza", get_pizza)
	Accesser.get_pizza_trigger().show_pizza()
	
	# Choose a random dev
	var possibly_hungry_developers: Array[Node] = get_tree().get_nodes_in_group("hungry_dev")
	var i = randi_range(0, possibly_hungry_developers.size() - 1)
	hungry_dev = possibly_hungry_developers[i]
	hungry_dev.start_animation("hungry")


func get_pizza() -> void:
	Accesser.get_pizza_trigger().disconnect("get_pizza", get_pizza)
	Accesser.get_pizza_trigger().hide_pizza()
	
	$StateMachinePlayer.set_trigger("get_pizza")

func bringing_food() -> void:
	Accesser.get_player().hold_node(pizza_ressource.instantiate())
	hungry_dev.connect("feed", feed_developer)

func feed_developer():
	$StateMachinePlayer.set_trigger("feed_developer")
	Accesser.get_player().hold_stop()
	hungry_dev.stop_animation()

func _on_state_machine_player_transited(from, to):
	match to:
		"hungry":
			hungry()
		"bring_food":
			bringing_food()
