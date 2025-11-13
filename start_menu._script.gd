extends Node2D

class_name Start_Menu

@export var lab_scene: PackedScene

func _on_button_pressed() -> void:
	var lab = lab_scene.instantiate()
	add_sibling(lab)
	self.queue_free()
