extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var tween : Tween
var is_active : bool

func enter() -> void:
	is_active = true
	anim.play(anim_name)
	anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)
	correction()

func next_state(_x):
	get_parent().change_state("Melee")

func update(delta: float) -> void:
	pass
	
func correction():
	#parent.global_rotation = fmod(parent.global_rotation, deg_to_rad(360))
	if tween:
		tween.kill()
	tween = create_tween()
	var angle = deg_to_rad(90)
	tween.tween_property($"../../Sprite2D","rotation",angle,0.5)
	tween.finished.connect(correction)	
	
func exit() -> void:
	is_active = false
