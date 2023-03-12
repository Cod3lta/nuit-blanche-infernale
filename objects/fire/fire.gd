extends Node3D

class_name Fire

var fire_elements: Array[Node] = [
	$GPUParticles3D,
	$GPUParticles3D2,
	$GPUParticles3D3,
	$GPUParticles3D4
]

signal exctincted

func start_fire():
	for fire_element in fire_elements:
		fire_element.set_emitting(true)

func stop_animation():
	for fire_element in fire_elements:
		fire_element.set_emitting(false)

func _on_area_3d_clicked():
	emit_signal("exctincted", self)
