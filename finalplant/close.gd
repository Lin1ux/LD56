extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var tween : Tween
var tween2 : Tween
var is_active : bool

func enter() -> void:
	is_active = true
	parent.set_vulnerable(true)
	parent.set_attacking(false)
	anim.play(anim_name)
	anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)
	if tween:
		tween.kill()
	
	tween = create_tween()
	#var angle = parent.get_angle_to(target.global_position)
	parent.global_rotation = fmod(parent.global_rotation,deg_to_rad(360))
	tween.tween_property(parent,"global_rotation",deg_to_rad(0),0.4)
	#tween.finished.connect(correction)	
	if tween2:
		tween2.kill()
	tween2 = create_tween()
	tween2.tween_property($"../../Node2D/Sprite2D","rotation",deg_to_rad(0),0.4)

func next_state(_x):
	if parent.should_sleep():
		get_parent().change_state("Sleep")
		return
	get_parent().change_state("Defence")
		

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false
