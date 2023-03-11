extends Area3D

signal clicked

func click():
	emit_signal("clicked")
