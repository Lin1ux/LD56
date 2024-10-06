extends Control

@export var required_exp : int = 1000
@export var current_exp : int = 0


func _ready() -> void:
	updade_progress_bar()
	set_text(1)

func set_curren_exp(amount : int):
	current_exp = amount
	updade_progress_bar()
	
func updade_progress_bar():
	$ProgressBar.value = current_exp
	$ProgressBar.max_value = required_exp
	
func set_text(level : int):
	$Label.text = "Lvl "+str(level)
