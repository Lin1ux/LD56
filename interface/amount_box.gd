extends Control

@export var texture : CompressedTexture2D ##texture of icon
@export var text : String ##Text

func _ready():
	set_icon(texture)
	set_text(text)

func set_icon(new_texture : CompressedTexture2D):
	$Icon.texture = new_texture
	
func set_text(new_text : String):
	$Value.text = new_text
