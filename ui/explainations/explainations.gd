extends Control

var game = preload("res://game.tscn")


func _on_button_pressed():
	get_tree().get_root().add_child(game.instantiate())
	queue_free()
