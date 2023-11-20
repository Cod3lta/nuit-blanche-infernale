extends Node
class_name MyStateMachine

# states = list of children nodes
# entry_state = $MyFirstState
@export var entry_state: MyState
var state: MyState
var transitionning: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	state = entry_state
	transitionning = false


func trigger(trigger):
	# cancel the trigger if we're transitionning
	if transitionning: return
	
	# transfer the action to the current state
	state.trigger(trigger)

func start_transition():
	transitionning = true
	print("start tr")

# called at the end of a transition to set the new state
func set_state(new_state: MyState):
	state = new_state
	transitionning = false
	print("end tr")

func get_current() -> MyState:
	return state
