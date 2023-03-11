extends Node3D

signal get_pizza

func _on_area_3d_clicked():
	emit_signal("get_pizza")
