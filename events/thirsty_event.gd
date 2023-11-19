extends Node

# Sound
# @export var event_start_hungry: EventAsset

@onready var thirsty_trigger = get_node("/root/Game/ThirstyTrigger")


func start_event():
	if $StateMachinePlayer.get_current() == "broken":
		return
	thirsty_trigger.break_fountain()
	thirsty_trigger.connect("click_fountain", repairing)
	# Play sound
	#FMODRuntime.play_one_shot_attached(event_start_hungry, hungry_dev)
	$StateMachinePlayer.set_trigger("breaking")


func waiting():
	pass


func broken() -> void:
	pass

func repairing() -> void:
	thirsty_trigger.repair_fountain()
	thirsty_trigger.disconnect("click_fountain", repairing)
	$StateMachinePlayer.set_trigger("repairing")


func _on_state_machine_player_transited(_from, to):
	match to:
		"waiting":
			waiting()
		"broken":
			broken()
