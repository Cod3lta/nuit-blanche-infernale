extends Node


@export var event_fire_start: EventAsset

var fires : Array[Fire]
var exctinctor_ressource = preload("res://objects/extinguisher/exctinguisher.tscn")
@onready var exctinctor_trigger = get_node("/root/Game/ExctinctorTrigger")
@onready var state_machine = $StateMachine

func _ready():
	state_machine.init(self)


func start_event():
	# Choose a random fire
	var possible_fires: Array[Node] = get_tree().get_nodes_in_group("fire")
	possible_fires = possible_fires.filter(func(fire): return fire not in fires)
	if possible_fires.size() < 1:
		return
	var i = randi_range(0, possible_fires.size() - 1)
	var fire = possible_fires[i]
	fire.show_fire()
	fires.push_back(fire)
	# Play sound
	# FMODRuntime.play_one_shot(event_fire_start, fire)
	# Make the exctinguisher interactible if we have the extinctor in hand
	if state_machine.get_current() == state_machine.get_node("CanExtinguish"):
		fire.connect("extinguish", state_machine.get_current().exctinct_fire)
	state_machine.trigger("new_fire")


"""********************************************
			STATE MACHINE HANDLING
********************************************"""


#func fire() -> void:
#	exctinctor_trigger.connect("click_exctinctor", get_exctinctor)


#func get_exctinctor() -> void:
	## Can't get the exctinctor if the player is already holding something
	#if Accesser.get_player().is_holding(): return
	#exctinctor_trigger.hide_exctinctor()
	#Accesser.get_player().hold_node(exctinctor_ressource.instantiate())
	#state_machine.trigger("get_exctinctor")


#func can_extinguish() -> void:
	#exctinctor_trigger.disconnect("click_exctinctor", bring_back_exctinctor)
	#exctinctor_trigger.disconnect("click_exctinctor", get_exctinctor)
	#for fire in fires:
		#fire.connect("extinguish", exctinct_fire)


#func no_more_fire() -> void:
	#exctinctor_trigger.connect("click_exctinctor", bring_back_exctinctor)


func bring_back_exctinctor() -> void:
	exctinctor_trigger.show_exctinctor()
	print("exctinctor back")
	exctinctor_trigger.disconnect("click_exctinctor", bring_back_exctinctor)
	Accesser.get_player().hold_stop()
	state_machine.trigger("bring_back_exctinctor")


#func exctinct_fire(fire: Fire):
	#fire.disconnect("extinguish", exctinct_fire)
	#fire.hide_fire()
	#fires.erase(fire)
	#if fires.size() == 0:
		#state_machine.trigger("exctinct_all_fires")
