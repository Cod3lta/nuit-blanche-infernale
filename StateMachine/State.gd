extends Node
class_name MyState

@export var state_machine: MyStateMachine

func _ready():
	pass


# Triggers a change to a new state
# The return value is true if the new state exists
func trigger(trigger: String) -> bool: 
	push_error("The trigger function isn't re-implemented")
	return false

func start_transition():
	state_machine.start_transition()
