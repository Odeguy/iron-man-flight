extends Node2D

class_name Suit


var arm1: Component
var arm2: Component
var leg1: Component
var leg2: Component
var torso: Component
var helmet: Component
var fuel: float
signal toggle_thrust
	
func _physics_process(delta: float) -> void:
	if fuel <= 0:
		fuel =  0
		toggle_thrust.emit()
	if torso.thrust_enabled: fuel -= 0.5
		
func build(f: int) -> void:
	fuel = f
	
	arm1.position = $ArmMarkerL.position
	arm2.position = $ArmMarkerR.position
	arm2.flip()
	leg1.position = $LegMarkerL.position
	leg2.position = $ArmMarkerR.position
	leg2.flip()
	torso.position = $TorsoMarker.position
	helmet.position = $HelmetMarker.position
	
	
	ready_component(torso)
	ready_component(arm1)
	ready_component(arm2)
	ready_component(leg1)
	ready_component(leg2)
	ready_component(helmet)

func ready_component(component: Component) -> void:
	await add_child(component)
	self.connect("toggle_thrust", component.toggle_thrust)
	if component != torso:
		attach_bodies(component.get_body_path(), torso.get_body_path())

func attach_bodies(body1: String, body2: String) -> void:
	var joint = DampedSpringJoint2D.new()
	joint.node_a = body1
	joint.node_b = body2
	joint.stiffness = 1000
	joint.length = 0.1
	joint.rest_length = 0.01
	joint.disable_collision = false
	joint.damping = 1
	add_child(joint)
	
func ready_for_build() -> bool:
	if arm1 == null: return false
	if arm2 == null: return false
	if leg1 == null: return false
	if leg2 == null: return false
	if helmet == null: return false
	if torso == null: return false
	return true
