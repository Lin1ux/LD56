@tool
class_name Flower
extends Node2D

@export var texture_used : int = 1
@export var image : CompressedTexture2D		##texture of object
@export var max_pollens : int = 5			##max amount of pollens which can be stored at once
@export var rotten_image : CompressedTexture2D
var progress_bar : Node
var current_pollens : int


var rotting : bool = false
func _ready():
	if Engine.is_editor_hint():
		return
	
	$AnimationPlayer.play("spawn")
	
	progress_bar = $ProgressBar
	current_pollens = max_pollens
	progress_bar.max_value = current_pollens
	progress_bar.value = current_pollens
	
func _process(delta: float) -> void:
	$Sprites/Sprite2D.texture = image
	
	if Engine.is_editor_hint():
		return
	
func gather_pollen(character : Node):
	#checking is character have backpack component
	if rotting:
		return
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
		$CollectSound.play()
		
		$"AnimationPlayer".stop()
		$"AnimationPlayer".play("pulse")
		
		

func _on_timer_timeout() -> void:
	if not rotting:
		if max_pollens > current_pollens:
			current_pollens += 1
			progress_bar.value = current_pollens
		
func get_flower_position():
	return global_position
	
func set_image(texture :CompressedTexture2D):
	image = texture

func start_rot_timer():
	$Rottimer.start()

func _on_rottimer_timeout() -> void:
	print("(fin ) timer")
	rotting = true
	$CompHP.vulnerable = true
	set_image(rotten_image)
	
func set_rand_pos(start_pos : Vector2):
	self.position = Vector2(randf_range(start_pos.x-400,start_pos.y+400),randf_range(start_pos.y-400,start_pos.y+400))
	
