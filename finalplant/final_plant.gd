extends Enemy

enum actions {DEFENCE,SHOT,MELEE} 
@export_group("Targets")
@export var bee_manager : Node				##Bee manager to pick target from
@export var HP_component : Node
@export_group("Ranges")
@export var range : float 					##How far can it go
@export var fight_range : float = 1000			##How far target have to be to stop fighting
@export_group("spawn things") 
@export var bullet_container : Node 		##Place where bullets is spawned
@export var bullet : PackedScene			##Bullet  which is used to shoot
@export var root : PackedScene				##Spawning roots
var start_pos : Vector2
var target : BeeControler
var next_action

var attacking: bool = true

func _ready():
	start_pos = self.global_position

func get_target():
	return target
	
func get_new_target():
	target = bee_manager.get_random_bee()
	return target
	
func _process(delta):
	pass
	
func change_action():
	next_action = actions.SHOT
	#next_action = randi_range(0,2)
	print("Next Action")
	return next_action

func get_action():
	return next_action

func get_start_pos():
	return start_pos
	
func should_fall_back():
	return start_pos.distance_squared_to(self.global_position) > range*range
	
func should_sleep():
	if target == null:
		get_new_target()
	return start_pos.distance_squared_to(target.global_position) > fight_range*fight_range
	
func spawn_bullet():
	var b = bullet.instantiate()
	b.set_pos($Node2D/Sprite2D/Marker2D.global_position)
	b.set_rot($Node2D/Sprite2D/Marker2D.global_rotation + deg_to_rad(-90))
	bullet_container.add_child(b)
	
func spawn_roots(amount : int):
	for i in range(amount):
		var r = root.instantiate()
		r.set_rand_pos(self.global_position)
		bullet_container.add_child(r)
		
func set_vulnerable(mode : bool):
	HP_component.set_vulnerable(mode)
	
func set_attacking(can_attack : bool):
	attacking = can_attack
	
func can_deal_damage() -> bool:
	return attacking
	
