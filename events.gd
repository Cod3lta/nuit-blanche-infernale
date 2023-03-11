extends Node


var next_event_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(preload("res://events/hungry_event.tscn").instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
