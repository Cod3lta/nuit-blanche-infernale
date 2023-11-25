extends MyState


@export var can_extinguish_state: Node
@export var waiting_state: Node


func enter() -> void:
	parent.exctinctor_trigger.connect("click_exctinctor", parent.bring_back_exctinctor)


func exit() -> void:
	pass


func trigger(trigger: String):
	match trigger:
		"bring_back_extinctor":
			state_machine.change_state(waiting_state)
			return true
		
		"new_fire":
			state_machine.change_state(can_extinguish_state)
			return true
	return false
