extends CharacterBody3D

@export var speed: float = 3.0
@export var sprint_speed: float = 5.0  
@export var acceleration: float = 40.0
@export var gravity: float = 9.8
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.65

@onready var head: Node3D = $head
@onready var camera: Camera3D = $head/Camera3D

var camera_x_rotation: float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation
	if Input.is_action_just_pressed("toggle") and $head/Camera3D/SpotLight3D.visible == true:
		$AudioStreamPlayer3D.play()
		$head/Camera3D/SpotLight3D.visible = false
	elif Input.is_action_just_pressed("toggle") and $head/Camera3D/SpotLight3D.visible == false:
		$AudioStreamPlayer3D.play()
		$head/Camera3D/SpotLight3D.visible = true

func _physics_process(delta):
	var movement_vector = Vector3.ZERO

	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head.basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head.basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head.basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head.basis.x

	movement_vector = movement_vector.normalized()

	var current_speed = sprint_speed if Input.is_action_pressed("shift") else speed

	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jumping
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_power

	move_and_slide()
