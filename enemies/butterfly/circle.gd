extends Node

@export var parent : Node
@export var speed_multiplayer : float = 0.5
var tween : Tween

func enter() -> void:
	tween = create_tween()
	tween.finished.connect(next_state)
	var degree = randi_range(720,1440)
	#var degree = 360+120
	var time = degree/144
	tween.tween_property(parent,"rotation",parent.global_rotation + deg_to_rad(degree),time)

func next_state():
	get_parent().change_state("moveTowards")

func update(delta: float) -> void:
	parent.velocity = fly_forward(delta)
	parent.move_and_slide()
	
func exit() -> void:
	if parent.is_spawn_flower():
		parent.spawn_flower()
		#print("Spawn flower")

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(parent.rotation) * parent.get_speed() * delta * 100 * speed_multiplayer
	
