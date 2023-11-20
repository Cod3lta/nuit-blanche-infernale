extends MyState


@export var hungry_state: Node
@export var waiting_state: Node
@export var hungry_event: Node

func _ready():
	if hungry_event.has_method("bring_food"):
		hungry_event.bring_food()


func trigger(trigger: String):
	match trigger:
		"still_hungry":
			
			# Play sound
			# then go the "closed" state
			state_machine.set_state(hungry_state)
		"fed_everyone":
			
			# Play sound
			# then go the "closed" state
			state_machine.set_state(waiting_state)
