extends CharacterBody3D

class_name Developer

signal feed

func start_animation(animation: String):
	if $AnimationPlayer.has_animation(animation):
		$AnimationPlayer.play(animation)
	else:
		print("The animation %s doesnt exist" % animation)

func stop_animation():
	$AnimationPlayer.play("RESET")

func _on_area_3d_clicked():
	emit_signal("feed", self)
