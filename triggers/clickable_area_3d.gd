extends Area3D

class_name ClickableArea3D

signal clicked

func click():
	emit_signal("clicked")
