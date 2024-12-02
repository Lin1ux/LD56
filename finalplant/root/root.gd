extends Node2D

@export var anim : AnimationPlayer

func _ready() -> void:
	anim.play("spawn")
	#set_rand_pos(Vector2(0,0))
	
func set_rand_pos(start_pos : Vector2):
	self.global_position = Vector2(randf_range(start_pos.x-200,start_pos.y+200),randf_range(start_pos.y-200,start_pos.y+200))

func remove():
	self.queue_free()
