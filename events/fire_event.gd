extends Event


#@export var event_fire_start: EventAsset

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
	state_machine.trigger("new_fire")


# used by multiple states
func bring_back_exctinctor() -> void:
	exctinctor_trigger.show_exctinctor()
	Accesser.get_player().hold_stop()
	state_machine.trigger("bring_back_extinctor")
