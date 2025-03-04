extends Node2D

@export var anim : AnimationPlayer
var spawned = false

func _ready() -> void:
	anim.play("spawn")
	#set_rand_pos(Vector2(0,0))
	
func set_spawned(can_damage : bool):
	spawned = can_damage
	$DespawnTimer.start()
	
func set_rand_pos(start_pos : Vector2):
	self.global_position = Vector2(randf_range(start_pos.x-200,start_pos.x+200),randf_range(start_pos.y-100,start_pos.y+100))

func remove():
	self.queue_free()
	
func can_deal_damage():
	return spawned;
	
func enemy_atacked():
	anim.play("hide")
	
func death():
	anim.play("hide")

func _on_despawn_timer_timeout() -> void:
	anim.play("hide")
