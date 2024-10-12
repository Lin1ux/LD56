extends Enemy

@export var flower_manager : Node
@export var spawn_range : float ##how far can spawn flowers
@export var images : Array[CompressedTexture2D]
@export var flower : PackedScene
var flower_position : Vector2
var f : Node
var ready_to_rot_flower : bool = false
func get_new_position():
	var pos_type = randi_range(0,10)
	var pos = self.global_position
	f = flower_manager.get_random_flower()
	if f == null:
		return Vector2.ZERO
	else:
		flower_position = f.get_position()
		if pos_type >= 5 and not f.rotting:
	#if pos_type > 9:
			ready_to_rot_flower = true
			return flower_position
	
		ready_to_rot_flower = false
		return flower_position
	
func is_rot_flower():
	return ready_to_rot_flower
	
func rot_flower():
	if is_instance_valid(f):
		if not f.rotting:
			f.rotting = true
			f.get_node("CompHP").vulnerable = true
			flower_manager.flower_list.erase(f)
			var texture: CompressedTexture2D = load("res://flower/flower" + str(f.texture_used) + "_rotting.png")
			f.set_image(texture)
		return
		
func _ready() -> void:
	$SpawnSound.play()
	
