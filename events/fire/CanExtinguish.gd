extends MyState


@export var fire_state: Node
@export var no_more_fire_state: Node


func enter() -> void:
	parent.exctinctor_trigger.disconnect("click_exctinctor", parent.bring_back_exctinctor)
	parent.exctinctor_trigger.disconnect("click_exctinctor", parent.get_exctinctor)
	for fire in parent.fires:
		fire.connect("extinguish", exctinct_fire)


func exit() -> void:
	pass


func exctinct_fire(fire: Fire):
	print("fireEvent recieved the extinct_fire signal")
	fire.disconnect("extinguish", exctinct_fire)
	fire.hide_fire()
	parent.fires.erase(fire)
	if parent.fires.size() == 0:
		state_machine.trigger("exctinct_all_fires")


func trigger(trigger: String):
	match trigger:
		"bring_back_extinctor":
			state_machine.change_state(fire_state)
			return true
		
		"extinct_all_fires":
			state_machine.change_state(no_more_fire_state)
			return true
	return false

