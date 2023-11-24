extends Node
class_name MyStateMachine

# states = list of children nodes
# entry_state = $MyFirstState
@export var entry_state: MyState
var state: MyState
var transitionning: bool
var parent: Node

signal transited(from: MyState, to: MyState)

# Called when the node enters the scene tree for the first time.
func _ready():
	state = entry_state
	transitionning = false


func init(parent_: Node) -> void:
	parent = parent_
	for child: Node in get_children():
		child.parent = parent_


func trigger(trigger):
	# cancel the trigger if we're transitionning
	if transitionning: return
	
	# transfer the trigger to the current state
	var state_exists: bool = state.trigger(trigger)
	# if the new state we're trying to go to exists, we end the transition
	transitionning = state_exists


# called at the end of a transition to set the new state
func set_state(new_state: MyState):
	transited.emit(state, new_state)
	state = new_state
	state.parent = parent
	state.enter()
	transitionning = false

func get_current() -> MyState:
	return state
