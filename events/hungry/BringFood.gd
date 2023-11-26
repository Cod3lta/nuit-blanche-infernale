extends MyState


@export var hungry_state: Node
@export var waiting_state: Node
@export var hungry_event: Node


func enter() -> void:
	for dev in parent.hungry_developers:
		dev.connect("feed", feed_developer)


func exit() -> void:
	for dev in parent.hungry_developers:
		dev.disconnect("feed", feed_developer)


func feed_developer(dev: Developer):
	Accesser.get_player().hold_stop()
	dev.stop_animation()
	parent.hungry_developers.erase(dev)
	
	if parent.hungry_developers.size() > 0:
		state_machine.trigger("still_hungry")
	else:
		state_machine.trigger("fed_everyone")


func trigger(trigger: String):
	match trigger:
		"still_hungry":
			state_machine.change_state(hungry_state)
			return true
		"fed_everyone":
			state_machine.change_state(waiting_state)
			return true
		"new_hungry_dev":
			# the new hungry dev is at the back of the array
			parent.hungry_developers[-1].connect("feed", feed_developer)
			return true
	return false
