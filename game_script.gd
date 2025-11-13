extends Node2D

class_name Game

@export var start_menu_scene: PackedScene

func _ready() -> void:
	var start_menu = start_menu_scene.instantiate()
	add_child(start_menu)
