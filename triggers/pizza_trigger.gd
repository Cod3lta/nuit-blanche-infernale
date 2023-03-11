extends Node3D

signal get_pizza

func _on_area_3d_clicked():
	emit_signal("get_pizza")

func show_pizza():
	$Pizza.set_visible(true)

func hide_pizza():
	$Pizza.set_visible(false)
