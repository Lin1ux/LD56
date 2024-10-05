extends Area2D

@export var parent : Node 		##Parent of component

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	for i in areas:
		if i.has_method("in_area"):
			i.in_area(parent)
			break
	
