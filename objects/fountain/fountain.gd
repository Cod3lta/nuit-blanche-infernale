extends Node3D

signal click_fountain

func _ready():
	repair_fountain()

func break_fountain():
	$GPUParticles3D.set_emitting(true)
	$GPUParticles3D2.set_emitting(true)
	$CSGCombiner3D.set_visible(true)


func repair_fountain():
	$GPUParticles3D.set_emitting(false)
	$GPUParticles3D2.set_emitting(false)
	$CSGCombiner3D.set_visible(false)


func _on_clickable_area_3d_clicked():
	emit_signal("click_fountain")
