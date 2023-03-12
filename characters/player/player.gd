extends CharacterBody3D

class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 5.5
const ROTATION_SPEED = 0.1

@onready var camera: Camera3D = $Camera3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= deg_to_rad(event.relative.x * ROTATION_SPEED)
		camera.rotation.x -= deg_to_rad(event.relative.y * ROTATION_SPEED)
	if event is InputEventMouseButton:
		var collider: Node = $Camera3D/RayCast3D.get_collider()
		if collider and collider.has_method("click"):
			collider.click()


func hold_node(node: Node3D) -> void:
	$Hand.add_child(node)


func hold_stop() -> void:
	for item in $Hand.get_children():
		item.queue_free()
