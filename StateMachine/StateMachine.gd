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
	assert(entry_state != null, "Missing entry state")


func init(parent_: Node) -> void:
	parent = parent_
	for child: Node in get_children():
		child.parent = parent_


func trigger(trigger):
	# cancel the trigger if we're transitionning
	if transitionning: return
	
	# transfer the trigger to the current state
	var state_exists: bool = state.trigger(trigger)
	if !state_exists:
		push_warning("Tried to enter a non-existing state")
	else:
		# if the new state we're trying to go to exists, we end the transition
		transitionning = false
	


# called at the end of a transition to set the new state
func change_state(new_state: MyState):
	transited.emit(state, new_state)
	new_state.parent = parent
	state.exit()
	new_state.enter()
	state = new_state
	transitionning = false

func get_current() -> MyState:
	return state
