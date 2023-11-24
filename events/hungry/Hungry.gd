extends MyState


@export var bring_food_state: Node
@export var hungry_event: Node


func enter() -> void:
	parent.pizza_trigger.connect("get_pizza", parent.get_pizza)
	for dev in parent.hungry_developers:
		dev.disconnect("feed", parent.feed_developer)


func trigger(trigger: String):
	match trigger:
		"get_pizza":
			state_machine.set_state(bring_food_state)
			return true
	return false

