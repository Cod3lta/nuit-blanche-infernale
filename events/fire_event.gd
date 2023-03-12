extends Node

var fires : Array[Fire]
var exctinctor_ressource = preload("res://objects/pizza/Pizza.tscn")

func _ready():
	pass

func waiting():
	pass

func new_fire():
	# Choose a random fire
	var possible_fires: Array[Node] = get_tree().get_nodes_in_group("fire")
	possible_fires = possible_fires.filter(func(fire): return fire not in fires)
	if possible_fires.size() < 1:
		return
	var fire
	var i = randi_range(0, possible_fires.size() - 1)
	fire = possible_fires[i]
	fire.start_fire()
	fires.push_back(fires)
	# Add a new pizza in the kitchen
	Accesser.get_pizza_trigger().add_pizza()
	
	$StateMachinePlayer.set_trigger("new_fire")


func fire() -> void:
	Accesser.get_pizza_trigger().connect("get_exctinctor", get_exctinctor)
	for dev in fires:
		dev.disconnect("exctincted", exctinct_fire)


func get_exctinctor() -> void:
	Accesser.get_pizza_trigger().remove_pizza()
	Accesser.get_player().hold_node(exctinctor_ressource.instantiate())
	$StateMachinePlayer.set_trigger("get_exctinctor")


func bring_food() -> void:
	Accesser.get_pizza_trigger().disconnect("get_exctinctor", get_exctinctor)
	for dev in fires:
		dev.connect("exctincted", exctinct_fire)


func exctinct_fire(dev: Developer):
	Accesser.get_player().hold_stop()
	dev.stop_animation()
	fires.erase(dev)
	if fires.size() > 0:
		$StateMachinePlayer.set_trigger("still_hungry")
	else:
		$StateMachinePlayer.set_trigger("fed_all_developers")


func _on_state_machine_player_transited(from, to):
	match to:
		"waiting":
			waiting()
		"fire":
			fire()
		"bring_food":
			bring_food()


func _on_event_timer_timeout():
	new_fire()
