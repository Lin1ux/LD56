extends CanvasLayer



func _ready() -> void:
	$AnimationPlayer.play("pop_in")
	get_tree().paused = true

func set_title(text: String):
	$Control/Panel/Title.text = text

func set_description(text: String):
	$Control/Panel/Description.text = text
	
func set_icon(texture: CompressedTexture2D):
	$Control/Panel/SpriteContainer/OutlineShader/Sprite2D.texture = texture

func _on_button_pressed() -> void:
	$AnimationPlayer.play("pop_out")
	get_tree().paused = false



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pop_out":
		queue_free()
