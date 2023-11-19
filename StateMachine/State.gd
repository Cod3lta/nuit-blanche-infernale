extends Node
class_name MyState

@export var state_machine: MyStateMachine

func _ready():
	pass


func trigger(trigger: String):
	push_error("The trigger function isn't re-implemented")

func start_transition():
	state_machine.start_transition()
