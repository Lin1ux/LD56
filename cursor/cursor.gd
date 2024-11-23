extends Control

var target := preload("res://cursor/cursor_target.tscn")

func _ready() -> void:
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta: float) -> void:
	position = get_viewport().get_mouse_position()

func _input(event: InputEvent) -> void:
	if not get_tree().paused:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				var t = target.instantiate()
				t.global_position = global_position
				get_parent().add_child(t)
			
