extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var is_active : bool

func enter() -> void:
	is_active = true
	anim.play(anim_name)
	parent.set_vulnerable(true)
	anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state(_x):
	if parent.should_sleep():
		get_parent().change_state("Close")
		return
	var action = parent.change_action()
	if parent.actions.SHOT == action:
		get_parent().change_state("PrepareCannon")
	if parent.actions.MELEE == action:
		get_parent().change_state("PrepareTeeth")
	if parent.actions.DEFENCE == action:
		get_parent().change_state("Close")

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false
