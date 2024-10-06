extends Node

@export var parent : CharacterBody2D
var start_location
var current_angle : float = 0
var tween : Tween

func enter() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	start_location = parent.rotation
	tween.tween_property(parent,"rotation",parent.rotation + deg_to_rad(180),2)
	tween.finished.connect(next_state)
	current_angle = parent.rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	
	var final_angle = current_angle+deg_to_rad(180) 
	
	#parent.look_at(Vector2.ZERO)
	#parent.rotation += parent.get_rotation_speed() * delta
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()

func exit() -> void:
	pass # Replace with function body.
	
func next_state():
	if parent.get_new_target().global_position.distance_squared_to(parent.global_position) < parent.engage_range_sqr():
		get_parent().change_state("Dash")
		return	
	get_parent().change_state("FlyForward")
	
	
func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100
