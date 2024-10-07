extends Enemy

@export var flower_manager : Node
@export var spawn_range : float ##how far can spawn flowers
@export var images : Array[CompressedTexture2D]
@export var flower : PackedScene
var flower_position : Vector2
var ready_to_spawn_flower : bool = true

func empty_backpack():
	get_backpack().remove_pollen()
	
func get_new_position():
	var pos_type = randi_range(0,10)
	var pos = self.global_position
	if pos_type > 5:
	#if pos_type > 9:
		flower_position = Vector2(randf_range(pos.x-spawn_range,pos.x+spawn_range),randf_range(pos.y-spawn_range,pos.y+spawn_range))
		ready_to_spawn_flower = true
		return flower_position
	flower_position = flower_manager.get_random_flower().get_flower_position()
	ready_to_spawn_flower = false
	return flower_position
	
func is_spawn_flower():
	return ready_to_spawn_flower
	
func spawn_flower():
	if len($CompInteractionArea.get_overlapping_areas()) > 1:
		return
	var f = flower.instantiate()
	f.global_position = self.global_position
	f.set_image(images[randi_range(0,len(images)-1)])
	flower_manager.add_new_child(f)
	flower_manager.add_flower(f)
