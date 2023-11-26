extends Control

var menu_explainations_ressource = preload("res://ui/explainations/explainations.tscn")

func _on_button_pressed():
	get_tree().get_root().add_child(menu_explainations_ressource.instantiate())
	queue_free()
