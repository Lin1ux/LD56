extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var target : BeeControler
var tween : Tween
var is_active : bool

func enter() -> void:
	is_active = true
	parent.set_vulnerable(true)
	anim.play(anim_name)
	anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func update(delta: float) -> void:
	pass
	
func correction():
	#parent.global_rotation = fmod(parent.global_rotation, deg_to_rad(360))
	if tween:
		tween.kill()
	tween = create_tween()
	var angle = parent.get_angle_to(target.global_position) + deg_to_rad(90)
	tween.tween_property(parent,"rotation",parent.global_rotation + angle,0.5)
	tween.finished.connect(correction)	
	
func next_state(_x):
	get_parent().change_state("Shot")
	
func exit() -> void:
	is_active = false
