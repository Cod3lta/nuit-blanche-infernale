extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_event_transited(from: MyState, to: MyState, name: String):
	print(name, ' : transited from ', from.get_name(), ' to ', to.get_name())
	var label: Label = get_node("VBoxContainer/" + name)
	label.set_text(name + " : " + to.get_name())


func _on_game_music_progressed(progression):
	$VBoxContainer/MusicProgression.set_text("Music progression: " + str(progression))
