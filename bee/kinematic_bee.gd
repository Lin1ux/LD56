extends CharacterBody2D
class_name BeeControler


signal dash_finished(BeeControler)
signal bee_dies(BeeControler)

var direction : Vector2
@export_group("Movement")
@export var acceleration : float = 40

@export var max_speed : float = 500

@export var random_shpere_radius : float = 50

@export var tween_duration: float = 0.2
var direction_tween: Tween

var side_acceleration : float
#Components
@export_group("Components")
@export var backpack : Node		##Component of backpack

@export var manager: Node2D

var dashing : bool
var dash_started: bool

@onready var bee_count_sprites = [$"Sprites/1", $"Sprites/2", $"Sprites/3", $"Sprites/4", $"Sprites/5", $"Sprites/6", $"Sprites/7"]

func _physics_process(delta):
	velocity = lerp(velocity,direction * max_speed ,0.5)
	
	$Sprites.look_at(velocity.rotated(PI/2))
	if $StateMachine.state.name == "Dash":
		$Sprites.modulate = Color(100.0, 100.0, 100.0)
	elif $CompBackpack.is_full():
		$Sprites.modulate = Color(255.0/255.0, 189.0/255.0, 64.0/256.0)
	else:
		$Sprites.modulate = Color.WHITE
		
	
	for i in range(bee_count_sprites.size()):
		if $CompHP.hp > i:
			bee_count_sprites[i].visible = true
			
			# Randomize fake bee location to look less predictable
			var update_rate := 4
			if Engine.get_physics_frames() % (Engine.physics_ticks_per_second / update_rate) == 0 and i > 1:
				var pos_tween = create_tween()
				pos_tween.tween_property(bee_count_sprites[i], "position", Vector2(randf_range(-10, 10), randf_range(-10, 10)), 1 / float(update_rate))
				pos_tween.set_trans(Tween.TRANS_LINEAR)
				#bee_count_sprites[i].position = Vector2(randf_range(-10, 10), randf_range(-10, 10))
		else:
			bee_count_sprites[i].visible = false
	
	move_and_slide()	
	
func provide_new_target_location(target: Vector2):
	$StateMachine/FlyTowards.set_new_target_location(target)

func new_target(target_position : Vector2):
	if direction_tween:
		direction_tween.kill()
		
	var new_direction = (target_position - position).normalized()

	direction_tween = create_tween()
	direction_tween.tween_property(self,"direction",new_direction,tween_duration)
	direction_tween.set_trans(Tween.TRANS_SPRING)
	
func get_backpack():
	return backpack
	
	
func dash():
	if direction_tween:
		direction_tween.kill()
	$StateMachine.do_dash()
	
func end_dash():
	$StateMachine/Dash.end_dash_prematurely()
	
func bee_died(fatal: bool):
	bee_dies.emit(self, fatal)
	
func can_deal_damage() -> bool:
	return $StateMachine.state.name == "Dash"
	


func _on_tree_exiting() -> void:
	manager.bees.erase(self)
	manager.UI.set_bees_amount(manager.get_amount_of_bees())
	manager.cursour_folowing.erase(self)
	manager.dashing_bees.erase(self)
	
