@tool
extends Node2D

var is_on_screen: bool = true

@export var sprite: CompressedTexture2D = preload("res://sprites/enemy_indicator.png")
@export_range(-180, 180, 0.001, "radians_as_degrees") var sprite_rotation: float = 0

@export var screen_size: Vector2 = Vector2i(640, 360)
@export var screen_margin: float = 32
@export var camera_position: Vector2 = Vector2.ZERO

@export var curve: Curve

func _process(delta: float) -> void:
	is_on_screen = (global_position.x >= camera_position.x - screen_size.x / 2)\
		and (global_position.x < camera_position.x + screen_size.x / 2)\
		and (global_position.y >= camera_position.y - screen_size.y / 2)\
		and (global_position.y < camera_position.y + screen_size.y / 2)
	
	$Indicator.visible = !is_on_screen
	$Indicator/Sprite2D.texture = sprite
	
	$Indicator/Sprite2D.look_at(global_position)
	$Indicator/Sprite2D.rotation += sprite_rotation
	# = Vector2.ONE * global_position.distance_to(camera_position) / 100.0)
	var distance_percentage = min(max(global_position.distance_to($Indicator.global_position) / screen_size.length(), 0), 1)
	var distance_scale = curve.sample_baked(distance_percentage)
	#print(distance_percentage, "   ", distance_scale)
	$Indicator/Sprite2D.scale = Vector2.ONE * distance_scale
	
	if is_on_screen:
		$Indicator.position = Vector2.ZERO
	else:
		$Indicator.global_position.x = clamp(global_position.x, camera_position.x - screen_size.x / 2 + screen_margin, camera_position.x + screen_size.x / 2 - screen_margin)
		$Indicator.global_position.y = clamp(global_position.y, camera_position.y - screen_size.y / 2 + screen_margin, camera_position.y + screen_size.y / 2 - screen_margin)
		
		
