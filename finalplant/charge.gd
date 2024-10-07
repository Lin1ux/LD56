extends Node

@export var parent : CharacterBody2D
@export var anim : AnimationPlayer	 
@export var anim_name : String
@export var multiplier : float = 2
var tween : Tween
var is_active : bool


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	$Timer.start()
	is_active = true
	anim.play(anim_name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	
func exit() -> void:
	is_active = false
	$Timer.stop()

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100 * multiplier
	
func next_state():
	get_parent().change_state("AfterCharge")

func _on_timer_timeout() -> void:
	next_state()
