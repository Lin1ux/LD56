extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var target : BeeControler
var tween : Tween
var is_active : bool

func enter() -> void:
	$Timer.start()
	parent.global_rotation = fmod(parent.global_rotation,360)
	is_active = true
	anim.play(anim_name)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(parent,"rotation",parent.global_rotation + deg_to_rad(360*5),10)
	tween.finished.connect(next_state)	
	#correction()
	
	#anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state():
	get_parent().change_state("HideCannon")

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	next_state()
