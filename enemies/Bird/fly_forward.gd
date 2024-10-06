extends Node


@export var parent : CharacterBody2D


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	
func exit() -> void:
	$Timer.stop()

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100

func _on_timer_timeout() -> void:
	print("end")
	get_parent().change_state("Rotate")
