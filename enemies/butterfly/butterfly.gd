extends Enemy

@export var flower_manager : Node
var flower_position : Vector2

func empty_backpack():
	get_backpack().remove_pollen()
	
func get_new_position():
	flower_position = flower_manager.get_random_flower().get_flower_position()
	return flower_position
	
