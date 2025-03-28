extends Area3D

@export var rotation_speed: float = 60.0  # Degrees per second
@export var float_speed: float = 1.5  # Speed of vertical movement
@export var float_height: float = 0.5  # Max height difference

var base_position: Vector3  # Store the initial position
var time_passed: float = 0.0

func _ready() -> void:
	base_position = global_transform.origin  # Store initial position

func _process(delta: float) -> void:
	# Rotate the key
	rotate_y(deg_to_rad(rotation_speed * delta))

	# Update vertical floating movement
	time_passed += delta * float_speed
	global_transform.origin.y = base_position.y + sin(time_passed) * float_height

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		print("Key obtained!")
		body.hasKey = true
		queue_free()
