extends Node2D

@export var enemy_container: Node2D
@export var flower_manager: Node2D
@export var bee_manager: Node2D

var wave_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_wave_timer_timeout()
	$WaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var fly = preload("res://fly/fly.tscn")
var bird = preload("res://enemies/bird/bird.tscn")
var big_bird = preload("res://enemies/bigbird/bigbird.tscn")
var butterfly = preload("res://enemies/butterfly/butterfly.tscn")
var final_plant = preload("res://finalplant/final_plant.tscn")

enum ENEMY { FLY, BIRD, BIG_BIRD, BUTTERFLY, FINAL_PLANT }
func spawn(enemy):
	match enemy:
		ENEMY.FLY:
			var f = fly.instantiate()
			f.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			f.flower_manager = flower_manager
			enemy_container.add_child(f)
		ENEMY.BIRD:
			var b = bird.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			b.bee_manager = bee_manager
			enemy_container.add_child(b)
		ENEMY.BIG_BIRD:
			var bb = big_bird.instantiate()
			bb.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			bb.bee_manager = bee_manager
			enemy_container.add_child(bb)
		ENEMY.BUTTERFLY:
			var b = butterfly.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 100
			b.flower_manager = flower_manager
			enemy_container.add_child(b)
		ENEMY.FINAL_PLANT:
			var f = final_plant.instantiate()
			f.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			f.bee_manager = bee_manager
			enemy_container.add_child(f)

var wave_map = [
	[ENEMY.BUTTERFLY, ENEMY.BUTTERFLY, ENEMY.BUTTERFLY],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.FLY],
	[ENEMY.BUTTERFLY, ENEMY.FLY, ENEMY.FLY, ENEMY.BIRD],
	[ENEMY.BUTTERFLY, ENEMY.BUTTERFLY, ENEMY.FLY, ENEMY.FLY, ENEMY.FLY, ENEMY.BIRD, ENEMY.BIRD],
	[ENEMY.FINAL_PLANT]
]

func _on_wave_timer_timeout() -> void:
	
	for enemy in wave_map[wave_number]:
		spawn(enemy)
	
	wave_number += 1
	wave_number = min(wave_number, wave_map.size() - 1)
