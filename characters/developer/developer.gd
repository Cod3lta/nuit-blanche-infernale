extends CharacterBody3D

class_name Developer

var instance_start_hungry: EventInstance
@export var event_start_hungry: EventAsset

signal feed

func _ready():
	$CSGCombiner3D.set_visible(false)
	if is_in_group("hungry_dev"):
		instance_start_hungry = FMODRuntime.create_instance(event_start_hungry)
		

func start_animation(animation: String):
	if $AnimationPlayer.has_animation(animation):
		$AnimationPlayer.play(animation)
		# TODO shouldn't be here
		instance_start_hungry.start()
		$CSGCombiner3D.set_visible(true)
	else:
		print("The animation %s doesnt exist" % animation)

func stop_animation():
	$AnimationPlayer.play("RESET")
	# TODO shouldn't be here
	instance_start_hungry.stop(FMODStudioModule.FMOD_STUDIO_STOP_ALLOWFADEOUT)
	$CSGCombiner3D.set_visible(false)

func _on_area_3d_clicked():
	emit_signal("feed", self)
