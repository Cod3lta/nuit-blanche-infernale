extends MyState


@export var can_extinguish_state: Node


func enter() -> void:
	parent.exctinctor_trigger.connect("click_exctinctor", get_exctinctor)


func exit() -> void:
	parent.exctinctor_trigger.disconnect("click_exctinctor", get_exctinctor)


func get_exctinctor() -> void:
	# Can't get the exctinctor if the player is already holding something
	if Accesser.get_player().is_holding(): return
	parent.exctinctor_trigger.hide_exctinctor()
	Accesser.get_player().hold_node(parent.exctinctor_ressource.instantiate())
	state_machine.trigger("get_exctinctor")


func trigger(trigger: String):
	match trigger:
		"get_exctinctor":
			state_machine.change_state(can_extinguish_state)
			return true
	return false

