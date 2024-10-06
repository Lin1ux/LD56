extends Node

@export var parent : Node
var point_to_move : Vector2
var tween : Tween

func enter() -> void:
	point_to_move = parent.get_new_position()
	tween = create_tween()
	tween.finished.connect(correction_angle)
	var degree = rad_to_deg(parent.get_angle_to(point_to_move))
	print("Degree = ",rad_to_deg(degree))
	degree += 360
	#if degree < 0:
	var time = degree/144
	tween.tween_property(parent,"rotation",parent.rotation + deg_to_rad(degree),time)

func next_state():
	parent.empty_backpack()
	get_parent().change_state("circle")

func update(delta: float) -> void:
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	parent.position.distance_squared_to(point_to_move)
	if parent.position.distance_squared_to(point_to_move) < 10:
		next_state()
	
func correction_angle():
	parent.look_at(point_to_move)
	
func exit() -> void:
	pass

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100 
	
	
