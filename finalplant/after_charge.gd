extends Node

@export var parent : CharacterBody2D
@export var anim : AnimationPlayer	 
@export var anim_name : String
@export var multiplier : float = 2
var tween : Tween
var is_active : bool


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	is_active = true
	anim.play(anim_name)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(parent,"global_position",parent.get_start_pos(),2)
	tween.finished.connect(next_state)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100 * multiplier
	
func next_state():
	get_parent().change_state("Melee")
