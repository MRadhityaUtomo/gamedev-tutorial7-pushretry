extends RayCast3D

@onready var player = get_parent().get_parent()  # Assuming the RayCast3D is inside a head/camera node under Player

func _process(delta):
	if not is_colliding():
		return

	var collider = get_collider()

	if collider is Interactable and Input.is_action_just_pressed("interact"):
		print("Picking up:", collider.name)

		# Try to add to inventory
		if player.inventory.add_item(collider):
			collider.queue_free()  # Remove the item from the world
		else:
			print("Inventory full!")
