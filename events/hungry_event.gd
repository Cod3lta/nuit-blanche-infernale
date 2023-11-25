extends Event

var hungry_developers : Array[Developer]
var pizza_ressource = preload("res://objects/pizza/Pizza.tscn")
@onready var pizza_trigger = get_node("/root/Game/PizzaTrigger")
@onready var state_machine = $StateMachine


func _ready():
	state_machine.init(self)


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
	state_machine.trigger("new_hungry_dev")


func get_pizza() -> void:
	pizza_trigger.remove_pizza()
	Accesser.get_player().hold_node(pizza_ressource.instantiate())
	state_machine.trigger("get_pizza")


func feed_developer(dev: Developer):
	Accesser.get_player().hold_stop()
	dev.stop_animation()
	hungry_developers.erase(dev)
	
	if hungry_developers.size() > 0:
		state_machine.trigger("still_hungry")
	else:
		state_machine.trigger("fed_everyone")


