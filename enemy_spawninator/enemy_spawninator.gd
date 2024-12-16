extends Node2D

@export var enemy_container: Node2D
@export var friendly_container: Node2D

@export var flower_manager: Node2D
@export var bee_manager: Node2D
@export var hive : Node2D
@export var bullet_container : Node2D
@export var UI : Node
var wave_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WaveTimer.start()
	#spawn(ENEMY.FINAL)	#Do testów NPC


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


var fly = preload("res://fly/fly.tscn")
var bird = preload("res://enemies/bird/bird.tscn")
var big_bird = preload("res://enemies/bigbird/bigbird.tscn")
var butterfly = preload("res://enemies/butterfly/butterfly.tscn")
var wasp = preload("res://enemies/wasp/wasp.tscn")
var final = preload("res://finalplant/final_plant.tscn")
var huge_bird = preload("res://huge_bird/huge_bird.tscn")

enum ENEMY { FLY, BIRD, BIG_BIRD, BUTTERFLY,WASP,FINAL,HUGE_BIRD }
func spawn(enemy):
	match enemy:
		ENEMY.FLY:
			var f = fly.instantiate()
			f.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			f.flower_manager = flower_manager
			enemy_container.add_child(f)
			$FlySpawn.play()
		ENEMY.BIRD:
			var b = bird.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			b.bee_manager = bee_manager
			enemy_container.add_child(b)
			$BirdSpawn.play()
		ENEMY.BIG_BIRD:
			var bb = big_bird.instantiate()
			bb.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			bb.bee_manager = bee_manager
			enemy_container.add_child(bb)
			$BigBirdSpawn.play()
		ENEMY.BUTTERFLY:
			var b = butterfly.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 100
			b.flower_manager = flower_manager
			friendly_container.add_child(b)
			$ButterflySpawn.play()
		ENEMY.WASP:
			var b = wasp.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 500
			b.hive = hive
			enemy_container.add_child(b)
			$WaspSpawn.play()
		ENEMY.FINAL:
			var b = final.instantiate()
			b.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 0
			b.bee_manager = bee_manager
			b.bullet_container = bullet_container
			b.UI = UI
			enemy_container.add_child(b)
		ENEMY.HUGE_BIRD:
			var hb = huge_bird.instantiate()
			hb.global_position = Vector2.RIGHT.rotated(randf_range(0, TAU)) * 700
			hb.bee_manager = bee_manager
			enemy_container.add_child(hb)
			$BigBirdSpawn.play()

var wave_map = [
	{ "func": HelpBoxManager.show_help.bind("Butterfly", "Helps you by spawning flowers!", preload("res://sprites/butterfly.png")),
		"spawn": [ENEMY.BUTTERFLY, ENEMY.BUTTERFLY] },
	{ "func": HelpBoxManager.show_help.bind("Fly", "Wants to ruin your flowers, get rid of it!", preload("res://fly/fly.png")),
		"wait_for_enemies_gone": true,
		"spawn": [ENEMY.FLY] },
	{ "func": HelpBoxManager.show_help.bind("Wasp", "If it reaches your hive, you'll take damage!", preload("res://enemies/wasp/wasp.png")),
		"wait_for_enemies_gone": true,
		"spawn": [ENEMY.WASP] },
	{ "func": HelpBoxManager.show_help.bind("Bird", "Watch out, it'll eat through your army if you don't attack!", preload("res://sprites/bird.png")),
		"wait_for_enemies_gone": true,
		"spawn": [ENEMY.BUTTERFLY,ENEMY.WASP, ENEMY.FLY,ENEMY.BIRD] },
	{ "wait_for_enemies_gone": true,
		"spawn": [ENEMY.WASP,ENEMY.WASP,ENEMY.FLY,ENEMY.FLY] },
	{ "spawn": [ENEMY.BUTTERFLY,ENEMY.WASP, ENEMY.FLY,ENEMY.BIRD] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.FLY] },
	{ "func": HelpBoxManager.show_help.bind("Big Bird", "A dangerous predator, don't get caught by surprise!", preload("res://enemies/bigbird/dreamberd.png")),
		"spawn": [ENEMY.BUTTERFLY, ENEMY.FLY, ENEMY.BIG_BIRD] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.FLY] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.FLY, ENEMY.BIRD] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.WASP] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.WASP, ENEMY.BIRD] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.FLY] },
	{ "spawn": [ENEMY.FLY, ENEMY.WASP, ENEMY.WASP, ENEMY.BIG_BIRD] },
	{ "spawn": [ENEMY.FLY, ENEMY.FLY, ENEMY.WASP] },
	{ "spawn": [ENEMY.FLY, ENEMY.WASP, ENEMY.WASP, ENEMY.BIG_BIRD] },
	{ "spawn": [ENEMY.FINAL] }
]

func process_wave():
	if wave_number >= wave_map.size():
		return
	
	# If all enemies need to be gone, wait and try again later
	if wave_map[wave_number].has("wait_for_enemies_gone") and wave_map[wave_number]["wait_for_enemies_gone"] == true:
		if get_tree().get_nodes_in_group("enemy").size() > 0:
			$WaveTimerTryAgain.start()
			return
		
	for enemy in wave_map[wave_number]["spawn"]:
		spawn(enemy)
		
	if wave_map[wave_number].has("func"):
		wave_map[wave_number]["func"].call()
	
	wave_number += 1
	
	$WaveTimer.start()
	return

func _on_wave_timer_timeout() -> void:
	process_wave()
	
func _on_wave_timer_try_again_timeout() -> void:
	process_wave()
