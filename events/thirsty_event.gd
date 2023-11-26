extends Event

# Sound
# @export var event_start_hungry: EventAsset

@onready var thirsty_trigger = get_node("/root/Game/ThirstyTrigger")
@onready var state_machine = $StateMachine

func _ready():
	state_machine.init(self)


func start_event():
	if state_machine.get_current() == state_machine.get_node("Broken"):
		return
	thirsty_trigger.break_fountain()
	thirsty_trigger.connect("click_fountain", repairing)
	# Play sound
	#FMODRuntime.play_one_shot_attached(event_start_hungry, hungry_dev)
	state_machine.trigger("break")


func repairing() -> void:
	thirsty_trigger.repair_fountain()
	thirsty_trigger.disconnect("click_fountain", repairing)
	state_machine.trigger("repair")
