@tool
extends CanvasLayer



func _ready() -> void:
	if not Engine.is_editor_hint():
		visible = false
		$AnimationPlayer.play("pop_in")
		get_tree().paused = true

func set_title(text: String):
	%Title.text = text

func set_description(text: String):
	%Description.text = text
	
func set_icon(texture: CompressedTexture2D):
	%Icon.texture = texture
	%Icon.scale.x = floor(%SpriteContainer.size.x / %Icon.texture.get_width())
	%Icon.scale.y = floor(%SpriteContainer.size.y / %Icon.texture.get_height())

func _on_button_pressed() -> void:
	$AnimationPlayer.play("pop_out")
	get_tree().paused = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		%Icon.scale.x = floor(%SpriteContainer.size.x / %Icon.texture.get_width())
		%Icon.scale.y = floor(%SpriteContainer.size.y / %Icon.texture.get_height())


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "pop_out":
		queue_free()
