extends Node2D

class_name Lab

@export var suit_scene: PackedScene
@export var stage_scene: PackedScene

@onready var suit: Suit = suit_scene.instantiate()

func _ready() -> void:
	load_armory()
	
func load_armory() -> void:
	var suits = JSON.parse_string(FileAccess.get_file_as_string("res://armory.json"))
	var root = $ScrollContainer/VBoxContainer
	for mark in suits:
		var scroll = ScrollContainer.new()
		scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
		root.add_child(scroll)
		
		var hbox = HBoxContainer.new()
		hbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
		scroll.add_child(hbox)
		
		var label = Label.new() #create theme file later?
		hbox.add_child(label)
		label.text = mark
		label.custom_minimum_size.y = 75
		
		for component_path: String in suits[mark]:
			var button = Button.new()
			button.expand_icon = true
			button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
			hbox.add_child(button)
			
			var component_scene: PackedScene = load(component_path)
			var component: Component = component_scene.instantiate()
			var extra: Component = component_scene.instantiate()
			button.icon = component.get_texture()
			button.pressed.connect(insert_component.bind(component, extra))
			
func insert_component(component: Component, extra: Component) -> void:
	var target_spot: Marker2D
	match component.type:
		"helmet":
			target_spot = $HelmetSpot
			suit.helmet = component
		"torso":
			target_spot = $TorsoSpot
			suit.torso = component
		"arm":
			target_spot = $ArmsSpot
			suit.arm1 = component
			suit.arm2 = extra
		"leg":
			target_spot = $LegsSpot
			suit.leg1 = component
			suit.leg2 = extra
	for area in target_spot.get_children():
		for child in area.get_children():
			if child is TextureRect: child.texture = component.get_texture()


func _on_button_pressed() -> void:
	if !suit.ready_for_build():
		var button_text = $Button.text
		$Button.text = "Finish Selection First"
		await get_tree().create_timer(0.5).timeout
		$Button.text = button_text
		return
	var stage: Stage = stage_scene.instantiate()
	var fuel = 100.0
	stage.iron_man = suit
	stage.lab = self
	add_sibling(stage)
	suit.build(fuel)
	self.hide()
	
