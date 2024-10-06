extends Node2D
	
@export var area : Area2D
@export var timer : Timer
@export var progress_bar : Node
	
func _ready():
	update_progress_bar()
	
func _process(delta):
	#print(timer.time_left)
	update_progress_bar()
	if area.has_overlapping_areas():
		if timer.is_stopped():
			timer.start()
		#print("overlap")
		return
	timer.stop()
	
	
func start_game():
	get_tree().change_scene_to_file("res://world.tscn")
	
func update_progress_bar():
	if timer.is_stopped():
		progress_bar.value = 0
		progress_bar.max_value = timer.wait_time
		return
	progress_bar.value = timer.wait_time - timer.time_left
	progress_bar.max_value = timer.wait_time
	
func _on_timer_timeout() -> void:
	print("1")
	start_game()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if timer.is_stopped():
		timer.start()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not area.has_overlapping_areas():
		timer.stop()
