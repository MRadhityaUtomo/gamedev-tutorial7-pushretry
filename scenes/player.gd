extends CharacterBody3D

@export var speed: float = 3.0
@export var sprint_speed: float = 5.0  
@export var crouch_speed: float = 1.5  
@export var acceleration: float = 40.0
@export var gravity: float = 12
@export var jump_power: float = 5.0
@export var mouse_sensitivity: float = 0.65
@export var crouch_ratio: float = 0.01  
@export var crouch_transition_speed: float = 10.0  

@onready var head: Node3D = $head 
@onready var camera: Camera3D = $head/Camera3D

var idle_bob_speed := 0
var idle_bob_amount := 0.00
var bob_time := 0.0 

var camera_x_rotation: float = 0.0
var is_crouching: bool = false
var original_head_height: float  
var target_head_height: float  
var hasKey = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	original_head_height = head.position.y
	target_head_height = original_head_height

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		camera_x_rotation = clamp(camera_x_rotation + x_delta, -90.0, 90.0)
		camera.rotation_degrees.x = -camera_x_rotation

	# Toggle flashlight
	if Input.is_action_just_pressed("toggle"):
		$AudioStreamPlayer3D.play()
		$head/Camera3D/SpotLight3D.visible = not $head/Camera3D/SpotLight3D.visible

	# Crouch mechanic
	if Input.is_action_just_pressed("ctrl"):
		is_crouching = !is_crouching
		target_head_height = original_head_height * crouch_ratio if is_crouching else original_head_height

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

	var current_speed = speed
	if Input.is_action_pressed("shift") and not is_crouching:
		current_speed = sprint_speed
	elif is_crouching:
		current_speed = crouch_speed

	velocity.x = lerp(velocity.x, movement_vector.x * current_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, movement_vector.z * current_speed, acceleration * delta)

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_crouching:
		velocity.y = jump_power

	head.position.y = lerp(head.position.y, target_head_height, crouch_transition_speed * delta)

	move_and_slide()
	
func _process(delta: float) -> void:
	camera_bob(delta)

func camera_bob(delta: float) -> void:
	var bob_offset := 0.0  
	if is_on_floor() and velocity.length() > 0.1:  
		bob_time += delta * (16 if Input.is_action_pressed("shift") else 10)
		bob_offset = sin(bob_time) * (0.10 if Input.is_action_pressed("shift") else 0.06)
	else:
		bob_time = 0.0
		bob_offset = lerp(bob_offset, 0.0, 10.0 * delta) 
	head.position.y = lerp(head.position.y, target_head_height + bob_offset, crouch_transition_speed * delta)
