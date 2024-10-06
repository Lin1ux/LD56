extends Node


func enter() -> void:
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta: float) -> void:
	pass
	
func exit() -> void:
	$Timer.stop()

func _on_timer_timeout() -> void:
	get_parent().change_state("Rotate")
