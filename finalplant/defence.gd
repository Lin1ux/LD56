extends Node

@export var parent : Node
@export var anim : AnimationPlayer	 
@export var anim_name : String
var is_active : bool

func enter() -> void:
	$Timer.start()
	is_active = true
	anim.play(anim_name)
	parent.set_vulnerable(false)
	parent.set_attacking(false)
	parent.spawn_roots(10)
	
	#anim.animation_finished.connect(next_state,ConnectFlags.CONNECT_ONE_SHOT)

func next_state():
	get_parent().change_state("Open")

func update(delta: float) -> void:
	pass
	
func exit() -> void:
	is_active = false
	$Timer.stop()

func _on_timer_timeout() -> void:
	next_state()
