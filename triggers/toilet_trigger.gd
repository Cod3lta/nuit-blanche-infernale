extends Node3D

signal click_toilet

func _ready():
	repair_toilet()

func repair_toilet() -> void:
	$GPUParticles3D2.set_emitting(false)
	$CSGCombiner3D.set_visible(false)

func break_toilet() -> void:
	$GPUParticles3D2.set_emitting(true)
	$CSGCombiner3D.set_visible(true)

func _on_clickable_area_3d_clicked():
	emit_signal("click_toilet")
