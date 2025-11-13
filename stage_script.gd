extends Node2D

class_name Stage


@onready var count := 0
@onready var threshold = 500
@onready var crossed_threshold := 0 #times threshold has been crossed
@onready var background := $Background1
@onready var not_background := $Background2
var iron_man: Suit

func _physics_process(delta: float) -> void:
	count += 1
	$Background1.position = iron_man.position
	$Background2.position = iron_man.position
	
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
	iron_man.toggle_thrust()
	$Button.mouse_filter = 2
