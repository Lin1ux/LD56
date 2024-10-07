extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var target : BeeControler

var is_active : bool

func enter() -> void:
	$Timer.start()
	is_active = true
	anim.play(anim_name)
	target = parent.get_new_target()
	
	#anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state():
	get_parent().change_state("MeleeCharge")

func update(delta: float) -> void:
	print("(Final",target.global_position)
	parent.look_at(target.global_position)
	#$"../../Sprite2D".rotation = 90
	
func exit() -> void:
	is_active = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	next_state()
