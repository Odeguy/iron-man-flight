extends Node2D

class_name Component

var thrust_enabled: bool = false
@export_enum("arm", "leg", "torso", "helmet") var type: String
@export var thrust: float
@export var inertia: float

func _ready() -> void:
	$RigidBody2D.mass = inertia
	
func toggle_thrust() -> bool:
	$RigidBody2D.constant_force = Vector2(0, 0)
	thrust_enabled = !thrust_enabled
	if thrust_enabled: 
		$RigidBody2D.add_constant_central_force(Vector2(0, -thrust * 50))
	else:
		$RigidBody2D.add_constant_central_force(Vector2(0, 981))
	
	return thrust_enabled

func get_texture() -> Texture:
	return $RigidBody2D/TextureRect.texture

func get_body() -> PhysicsBody2D:
	return $RigidBody2D
	
func get_body_path() -> String:
	return $RigidBody2D.get_path()
	
func get_collision_shape() -> CollisionObject2D:
	return $RigidBody2D/CollisionShape2D

func flip() -> void:
	$RigidBody2D/TextureRect.flip_h = true
