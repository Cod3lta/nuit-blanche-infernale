extends MyState


@export var bring_food_state: Node
@export var hungry_event: Node


func enter() -> void:
	parent.pizza_trigger.connect("get_pizza", get_pizza)


func exit() -> void:
	parent.pizza_trigger.disconnect("get_pizza", get_pizza)


func get_pizza() -> void:
	# Can't get the exctinctor if the player is already holding something
	if Accesser.get_player().is_holding(): return
	parent.pizza_trigger.remove_pizza()
	Accesser.get_player().hold_node(parent.pizza_ressource.instantiate())
	state_machine.trigger("get_pizza")


func trigger(trigger: String):
	match trigger:
		"get_pizza":
			state_machine.change_state(bring_food_state)
			return true
	return false

