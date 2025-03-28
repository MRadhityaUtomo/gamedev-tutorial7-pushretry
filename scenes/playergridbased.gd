extends Node3D

const TRAVEL_TIME := 0.5

@onready var front_ray := $FrontRay
@onready var back_ray := $BackRay

var tween

func _physics_process(delta):
	if Input.is_action_pressed("movement_forward") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.FORWARD * 2), TRAVEL_TIME)
	if Input.is_action_pressed("movement_backward") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated(Vector3.BACK * 2), TRAVEL_TIME)
	if Input.is_action_pressed("movement_left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI), TRAVEL_TIME)
	if Input.is_action_pressed("movement_right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI), TRAVEL_TIME)
