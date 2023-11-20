extends Node

# Sound
# @export var event_start_hungry: EventAsset

@export_node_path("Node3D") var toilet_path
@onready var toilet_trigger = get_node(toilet_path)


func start_event():
	if $StateMachine.get_current() == $StateMachine/Broken:
		return
	toilet_trigger.break_toilet()
	toilet_trigger.connect("click_toilet", repair)
	# Play sound
	#FMODRuntime.play_one_shot_attached(event_start_hungry, hungry_dev)
	$StateMachine.set_trigger("break")


func repair() -> void:
	toilet_trigger.repair_toilet()
	toilet_trigger.disconnect("click_toilet", repair)
	$StateMachine.set_trigger("repair")
