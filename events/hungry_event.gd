extends Event

var hungry_developers : Array[Developer]
var pizza_ressource = preload("res://objects/pizza/Pizza.tscn")
@onready var pizza_trigger = get_node("/root/Game/PizzaTrigger")
@onready var state_machine = $StateMachine


func _ready():
	state_machine.init(self)


func start_event():
	# Choose a random dev, animate it
	var possibly_hungry_devs = get_tree().get_nodes_in_group("hungry_dev") as Array[Developer]
	possibly_hungry_devs = possibly_hungry_devs.filter(func(dev): return dev not in hungry_developers)
	if possibly_hungry_devs.size() < 1:
		return
	var i = randi_range(0, possibly_hungry_devs.size() - 1)
	var hungry_dev = possibly_hungry_devs[i]
	hungry_dev.start_animation("hungry")
	# Play sound
	
	hungry_developers.push_back(hungry_dev)
	# Add a new pizza in the kitchen
	pizza_trigger.add_pizza()
	state_machine.trigger("new_hungry_dev")
