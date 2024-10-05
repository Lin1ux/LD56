extends Node2D

@export var image : CompressedTexture2D		##texture of object
@export var max_pollens : int = 5			##max amount of pollens which can be stored at once
var progress_bar : Node
var current_pollens : int
	
func _ready():
	progress_bar = $ProgressBar
	current_pollens = max_pollens
	progress_bar.max_value = current_pollens
	progress_bar.value = current_pollens
	$Sprite2D.texture = image
	
func gather_pollen(character : Node):
	#checking is character have backpack component
	if not character.has_method("get_backpack"):
		return
	var backpack = character.get_backpack()
	if backpack == null:
		return
	#moving pollen from object to backpack
	if current_pollens > 0 and not backpack.is_full():
		current_pollens -= 1
		backpack.increase_pollen(1)
		progress_bar.value = current_pollens
		$Timer.start()
		print("gathering")

func _on_timer_timeout() -> void:
	if max_pollens > current_pollens:
		print("timeout")
		current_pollens += 1
		progress_bar.value = current_pollens
