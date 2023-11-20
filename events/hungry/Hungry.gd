extends MyState


@export var bring_food_state: Node
@export var hungry_event: Node

func _ready():
	if hungry_event.has_method("hungry"):
		hungry_event.hungry()

func trigger(trigger: String):
	match trigger:
		"get_pizza":
			
			# Play sound
			# FMODRuntime.play_one_shot_attached(event_close_door, self)
			# play the closing animation
			
			# then go the "closed" state
			state_machine.set_state(bring_food_state)

