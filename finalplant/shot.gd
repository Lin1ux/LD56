extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var tween : Tween
var is_active : bool

func enter() -> void:
	var circles_count = randf_range(2,5)
	parent.global_rotation = fmod(parent.global_rotation,360)
	is_active = true
	anim.play(anim_name)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(parent,"rotation",parent.global_rotation + deg_to_rad(360*circles_count),3*circles_count)
	tween.finished.connect(next_rotation)	
	#correction()
	
	#anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_rotation():
	parent.global_rotation = fmod(parent.global_rotation,360)
	var circles_count = randf_range(2,5)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(parent,"rotation",parent.global_rotation - deg_to_rad(360*circles_count),3*circles_count)
	tween.finished.connect(next_state)	

func next_state():
	get_parent().change_state("HideCannon")

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false

#func _on_timer_timeout() -> void:
#	next_state()
	
func shoot():
	parent.spawn_bullet()
