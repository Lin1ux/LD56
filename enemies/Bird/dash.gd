extends Node

@export var parent : CharacterBody2D
@export var speed_multiplayer : float = 2 ##Increased speed
@export var change_state_distance = 100
var selected_target : BeeControler
var tween : Tween


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	selected_target = parent.get_target()
	
	if selected_target == null:
		get_parent().change_state("AfterDash")
		return
	
	correction()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	if selected_target == null:
		get_parent().change_state("AfterDash")
		return
	
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	if distance() < parent.after_dash_range_sqr():
		tween.kill()
		get_parent().change_state("AfterDash")
	
func correction():
	if tween:
		tween.kill()
	tween = create_tween()
	
	if selected_target == null:
		get_parent().change_state("AfterDash")
		return
	
	var angle = parent.get_angle_to(selected_target.global_position)
	tween.tween_property(parent,"rotation",parent.global_rotation + angle,parent.get_correction())
	tween.finished.connect(correction)	
	
func exit() -> void:
	pass

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100 * speed_multiplayer
	
func distance():
	return parent.global_position.distance_squared_to(selected_target.global_position)
