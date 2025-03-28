extends Node

const MAX_SLOTS = 4
var inventory: Array = []

func add_item(item):
	if inventory.size() < MAX_SLOTS:
		inventory.append(item)
		print("Picked up:", item.name)
		return true
	print("Inventory full!")
	return false

func remove_item(index):
	if index >= 0 and index < inventory.size():
		var removed_item = inventory.pop_at(index)
		print("Dropped:", removed_item.name)
		return removed_item
