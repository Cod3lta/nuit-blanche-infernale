extends Node


@export var event_fire_start: EventAsset

var fires : Array[Fire]
var exctinctor_ressource = preload("res://objects/extinguisher/exctinguisher.tscn")
@onready var exctinctor_trigger = get_node("/root/Game/ExctinctorTrigger")

func _ready():
	pass

func waiting():
	pass

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
	FMODRuntime.play_one_shot(event_fire_start, fire)
	# Make the exctinguisher available
	if $StateMachinePlayer.get_current() == "bring_exctinctor":
		fire.connect("extinguish", exctinct_fire)
	$StateMachinePlayer.set_trigger("new_fire")


func fire() -> void:
	exctinctor_trigger.connect("click_exctinctor", get_exctinctor)


func get_exctinctor() -> void:
	# Can't get the exctinctor if the player is already holding something
	if Accesser.get_player().is_holding(): return
	exctinctor_trigger.hide_exctinctor()
	Accesser.get_player().hold_node(exctinctor_ressource.instantiate())
	$StateMachinePlayer.set_trigger("get_exctinctor")


func bring_exctinctor() -> void:
	exctinctor_trigger.disconnect("click_exctinctor", bring_back_exctinctor)
	exctinctor_trigger.disconnect("click_exctinctor", get_exctinctor)
	for fire in fires:
		fire.connect("extinguish", exctinct_fire)


func return_exctinctor() -> void:
	exctinctor_trigger.connect("click_exctinctor", bring_back_exctinctor)


func bring_back_exctinctor() -> void:
	exctinctor_trigger.show_exctinctor()
	print("exctinctor back")
	exctinctor_trigger.disconnect("click_exctinctor", bring_back_exctinctor)
	Accesser.get_player().hold_stop()
	$StateMachinePlayer.set_trigger("bring_back_exctinctor")


func exctinct_fire(fire: Fire):
	fire.disconnect("extinguish", exctinct_fire)
	fire.hide_fire()
	fires.erase(fire)
	if fires.size() == 0:
		$StateMachinePlayer.set_trigger("exctinct_all_fires")


func _on_state_machine_player_transited(_from, to):
	match to:
		"waiting":
			waiting()
		"fire":
			fire()
		"bring_exctinctor":
			bring_exctinctor()
		"return_exctinctor":
			return_exctinctor()

