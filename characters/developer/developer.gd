extends CharacterBody3D

class_name Developer

func animate(animation: String):
	if $AnimationPlayer.has_animation(animation):
		$AnimationPlayer.play(animation)
	else:
		print("The animation %s doesnt exist" % animation)
