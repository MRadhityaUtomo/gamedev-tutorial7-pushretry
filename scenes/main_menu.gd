extends Control


@export var levelTest: String
@export var level1: String
@export var level2: String

func _levelTest_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/" + levelTest + ".tscn"))
	
func _level1_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/" + level1 + ".tscn"))
	
func _level2_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/" + level2 + ".tscn"))
