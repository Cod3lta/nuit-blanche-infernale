extends Node

# Sound
# @export var event_start_hungry: EventAsset

@export_node_path("Node3D") var toilet_path
@onready var toilet_trigger = get_node(toilet_path)
@onready var state_machine = $StateMachine

func _ready():
	state_machine.init(self)


func start_event():
	if state_machine.get_current() == state_machine.get_node("Broken"):
		return
	toilet_trigger.break_toilet()
	toilet_trigger.connect("click_toilet", repair)
	# Play sound
	#FMODRuntime.play_one_shot_attached(event_start_hungry, hungry_dev)
	state_machine.trigger("break")


func repair() -> void:
	toilet_trigger.repair_toilet()
	toilet_trigger.disconnect("click_toilet", repair)
	state_machine.trigger("repair")
