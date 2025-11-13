extends Node2D

class_name Component

@onready var thrust_enabled: bool = false
@export_enum("arm", "leg", "torso", "helmet") var type: String
@export var thrust: float
@export var inertia: float

func _ready() -> void:
	$RigidBody2D.mass = inertia
	
func toggle_thrust() -> bool:
	thrust_enabled = !thrust_enabled
	if thrust_enabled: $RigidBody2D.add_constant_central_force(Vector2(0, -thrust))
	else: $RigidBody2D.add_constant_central_force(Vector2(0, 0))
	
	return thrust_enabled
