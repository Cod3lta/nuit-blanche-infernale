extends Node3D

signal click_exctinctor

func _on_area_3d_clicked():
	emit_signal("click_exctinctor")

func show_exctinctor():
	$Exctinguisher.set_visible(true)

func hide_exctinctor():
	$Exctinguisher.set_visible(false)
