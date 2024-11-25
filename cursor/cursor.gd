extends Control

@export var bee_manager: Node
var target := preload("res://cursor/cursor_target.tscn")

func _ready() -> void:
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()
	
	if is_instance_valid(bee_manager):
		$DashCooldown.value = bee_manager.get_dash_cooldown()

func target_effect() -> void:
	var t = target.instantiate()
	t.global_position = global_position
	get_parent().add_child(t)
			
