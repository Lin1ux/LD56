extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
@export var target : BeeControler
@export var change_state_distance = 100
var tween : Tween

var is_active : bool

func enter() -> void:
	is_active = true
	anim.play(anim_name)
	target = parent.get_new_target()
	correction()
	
	#anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state():
	get_parent().change_state("melee")

func update(delta: float) -> void:
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	if distance() < change_state_distance * change_state_distance:
		tween.kill()
		get_parent().change_state("Charge")
	if parent.should_fall_back():
		tween.kill()
		get_parent().change_state("AfterCharge")
	
func exit() -> void:
	is_active = false

func _on_timer_timeout() -> void:
	next_state()
	
func correction():
	if tween:
		tween.kill()
	tween = create_tween()
	var angle = parent.get_angle_to(target.global_position)
	tween.tween_property(parent,"rotation",parent.global_rotation + angle,0.2)
	tween.finished.connect(correction)	

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100
	
func distance():
	return parent.global_position.distance_squared_to(target.global_position)
