extends Node2D

@export var enemy_container: Node2D
@export var flower_manager: Node2D
@export var bee_manager: Node2D
@export var hive : Node2D
var wave_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WaveTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var fly = preload("res://fly/fly.tscn")
var bird = preload("res://enemies/bird/bird.tscn")
var big_bird = preload("res://enemies/bigbird/bigbird.tscn")
var butterfly = preload("res://enemies/butterfly/butterfly.tscn")
var wasp = preload("res://enemies/wasp/wasp.tscn")

enum ENEMY { FLY, BIRD, BIG_BIRD, BUTTERFLY,WASP }
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
		ENEMY.WASP:
			var b = wasp.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 500
			b.hive = hive
			enemy_container.add_child(b)

var wave_map = [
	[ENEMY.BUTTERFLY, ENEMY.BUTTERFLY, ENEMY.FLY,ENEMY.WASP],
	[ENEMY.BUTTERFLY,ENEMY.WASP, ENEMY.FLY,ENEMY.BIRD],
	[ENEMY.WASP,ENEMY.WASP,ENEMY.FLY,ENEMY.FLY],
	[ENEMY.BUTTERFLY,ENEMY.WASP, ENEMY.FLY,ENEMY.BIRD],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.FLY],
	[ENEMY.BUTTERFLY, ENEMY.FLY, ENEMY.BIG_BIRD],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.FLY],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.FLY, ENEMY.BIRD],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.WASP],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.WASP, ENEMY.BIRD],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.FLY],
	[ENEMY.FLY, ENEMY.WASP, ENEMY.WASP, ENEMY.BIG_BIRD],
	[ENEMY.FLY, ENEMY.FLY, ENEMY.WASP],
	[ENEMY.FLY, ENEMY.WASP, ENEMY.WASP, ENEMY.BIG_BIRD],
]

func _on_wave_timer_timeout() -> void:
	
	for enemy in wave_map[wave_number]:
		spawn(enemy)
	
	wave_number += 1
	wave_number = min(wave_number, wave_map.size() - 1)
