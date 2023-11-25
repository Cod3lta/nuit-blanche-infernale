extends Node
class_name MyState

@onready var state_machine: MyStateMachine = get_parent()
var parent: Node


func enter() -> void:
	assert(false, "The enter function isn't re-implemented")


func exit() -> void:
	assert(false, "The exit function isn't re-implemented")


# Triggers a change to a new state
# The return value is true if the new state exists
func trigger(trigger: String) -> bool: 
	assert(false, "The trigger function isn't re-implemented")
	return false
