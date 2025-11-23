extends Node2D

class_name Stage


@onready var count := 0
@onready var threshold = 500
@onready var crossed_threshold := 0 #times threshold has been crossed
@onready var background := $Background1
@onready var not_background := $Background2
var screen_size = get_viewport_rect().size
var iron_man: Suit
var lab: Lab
var max_height: float = 0

func _ready() -> void:
	$Background1/GPUParticles2D.emitting = false
	add_child(iron_man)
	screen_size = get_viewport_rect().size
	iron_man.position = screen_size / 2

func _physics_process(delta: float) -> void:
	count += 1
	var pos = iron_man.torso.get_body().position.y
	$Background1.position.y = pos
	$Background2.position.y = pos
	var height = 0
	if pos < 0: height = abs(int(pos))
	if height > max_height: max_height = height
	var label_text = "Fuel: " + str(int(iron_man.fuel)) + "\nHeight: " + str(int(height)) + "\nMax Height: " + str(int(max_height))
	$Background1/Label.text = label_text
	$Background2/Label.text = label_text
	$Camera2D.position.y = pos + screen_size.y / 2
	
	var wind_y = (iron_man.torso.get_body().linear_velocity.y + 1) * -5
	$Background1/GPUParticles2D.process_material.set("initial_velocity", Vector2(0, wind_y))
	print(wind_y)
	
	if wind_y < -1: 
		$Background1/GPUParticles2D.position.y = 600
	else: 
		$Background1/GPUParticles2D.position.y = -448
	
	
	if iron_man.position.y >= threshold && crossed_threshold == 0:
		switch_background()
		crossed_threshold = 1
	if iron_man.position.y <= threshold && crossed_threshold == 1:
		switch_background()
		crossed_threshold = 2

func switch_background() -> void:
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	
	tween.tween_property(background, "modulate:a", 0, 2)
	await tween.tween_property(not_background, "modulate:a", 1, 2)
	
	var temp = background
	background = not_background
	not_background = temp

func _on_button_pressed() -> void:
	iron_man.toggle_thrust.emit()
	$Background1/GPUParticles2D.emitting = true
	$Button.mouse_filter = 2
	$Button.hide()
