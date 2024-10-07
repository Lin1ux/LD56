extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_rand_pos(start_pos : Vector2):
	self.position = Vector2(randf_range(start_pos.x-400,start_pos.y+400),randf_range(start_pos.y-400,start_pos.y+400))
