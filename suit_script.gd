extends Node2D

class_name Suit


var arms: Component
var legs: Component
var torso: Component
var helmet: Component
var fuel: float

func assemble_components(p_arms: Component, p_legs: Component, p_torso: Component, p_helmet: Component) -> void:
	arms = p_arms
	legs = p_legs
	torso = p_torso
	helmet = p_helmet
	
func toggle_thrust() -> void:
	arms.toggle_thrust()
	legs.toggle_thrust()
	torso.toggle_thrust()
	helmet.toggle_thrust()
	
func _physics_process(delta: float) -> void:
	fuel -= 0.01
	if fuel <= 0:
		fuel ==  0
		toggle_thrust()
		
	
