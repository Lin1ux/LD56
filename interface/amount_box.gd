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
	$CanvasGroup/Icon2.texture = texture
	$CanvasGroup/Icon3.texture = texture
	$CanvasGroup/Icon4.texture = texture
	$CanvasGroup/Icon5.texture = texture
	$CanvasGroup/Icon6.texture = texture
	$CanvasGroup/Icon7.texture = texture
	$CanvasGroup/Icon8.texture = texture
	$CanvasGroup/Icon9.texture = texture
	$CanvasGroup/Icon2.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon3.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon4.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon5.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon6.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon7.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon8.modulate = Color(100.0, 100.0, 100.0)
	$CanvasGroup/Icon9.modulate = Color(100.0, 100.0, 100.0)
	$Value.text = text
