@tool
extends Control

@export var texture : CompressedTexture2D ##texture of icon
@export var text : String ##Text

func set_icon(new_texture : CompressedTexture2D):
	texture = new_texture
	
func set_text(new_text : String):
	text = new_text
	
func _process(delta: float) -> void:
	$CanvasGroup/Icon.texture = texture
	$Value.text = text
