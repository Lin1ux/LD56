extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var is_active : bool

func enter() -> void:
	is_active = true
	anim.play(anim_name)
	anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state(_x):
	get_parent().change_state("Defence")
		

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false
