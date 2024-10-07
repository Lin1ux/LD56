extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var is_active : bool

func enter() -> void:
	is_active = true
	anim.play(anim_name)
	parent.set_vulnerable(false)
	

func next_state():
	get_parent().change_state("Open")

func update(delta: float) -> void:
	if parent.get_new_target().global_position.distance_squared_to(parent.global_position) < parent.engage_range_sqr():
		next_state()
	
func exit() -> void:
	is_active = false
