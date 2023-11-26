extends Node
class_name Event

signal transited(from: MyState, to: MyState)


func start_event():
	assert(false, "The start_event isn't re-implemented")


func _on_state_machine_transited(from, to):
	emit_signal("transited", from, to)
