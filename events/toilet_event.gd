extends Node

# Sound
# @export var event_start_hungry: EventAsset

@export_node_path("Node3D") var toilet_path
@onready var toilet_trigger = get_node(toilet_path)

@export var toilet_triggers: Array[Node3D]


func start_event():
	if $StateMachinePlayer.get_current() == "broken":
		return
	toilet_trigger.break_toilet()
	toilet_trigger.connect("click_toilet", repair)
	# Play sound
	#RuntimeManager.play_one_shot_attached(event_start_hungry, hungry_dev)
	$StateMachinePlayer.set_trigger("break")


func waiting():
	pass


func broken() -> void:
	pass

func repair() -> void:
	toilet_trigger.repair_toilet()
	toilet_trigger.disconnect("click_toilet", repair)
	$StateMachinePlayer.set_trigger("repair")


func _on_state_machine_player_transited(_from, to):
	match to:
		"waiting":
			waiting()
		"broken":
			broken()
