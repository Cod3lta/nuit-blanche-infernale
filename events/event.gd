extends Node
class_name Event

signal transited(from: MyState, to: MyState)

@export_range(0, 1, 0.01) var damage_per_frame: float = 0


func start_event():
	assert(false, "The start_event isn't re-implemented")


func _on_state_machine_transited(from, to):
	emit_signal("transited", from, to)
