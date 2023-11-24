extends MyState


@export var hungry_state: Node
@export var waiting_state: Node
@export var hungry_event: Node


func enter() -> void:
	parent.pizza_trigger.disconnect("get_pizza", parent.get_pizza)
	for dev in parent.hungry_developers:
		dev.connect("feed", parent.feed_developer)


func trigger(trigger: String):
	match trigger:
		"still_hungry":
			state_machine.set_state(hungry_state)
			return true
		"fed_everyone":
			state_machine.set_state(waiting_state)
			return true
	return false
