extends Node3D

class_name Fire

func _ready():
	hide_fire()

signal extinguish

@onready var fire_elements: Array[Node] = [
	$GPUParticles3D,
	$GPUParticles3D2,
	$GPUParticles3D3,
	$GPUParticles3D4
]


func show_fire():
	for fire_element in fire_elements:
		fire_element.set_emitting(true)
	$OmniLight3D.set_visible(true)

func hide_fire():
	for fire_element in fire_elements:
		fire_element.set_emitting(false)
	$OmniLight3D.set_visible(false)

func _on_area_3d_clicked():
	emit_signal("extinguish", self)
