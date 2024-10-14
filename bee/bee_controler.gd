extends Node2D
#class_name BeeControler


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
	
func _integrate_forces(state : PhysicsDirectBodyState2D):
	if dashing:
		state.linear_velocity *= 0.975
		
	elif dash_started:
		dashing = true
		dash_started = false
		state.linear_velocity *= 2.3
	else:
		
		state.apply_impulse(direction * acceleration)
		
		var side_motion = direction.rotated(deg_to_rad(90))
		state.apply_impulse(side_motion * side_acceleration)
		
		
		if state.linear_velocity.length() > max_speed:
			var dir = state.linear_velocity.normalized()
			state.linear_velocity = dir * max_speed
		
		$Sprites.look_at(state.linear_velocity.rotated(PI/2))
		
func _physics_process(delta):
		
		
	if $StateMachine.state.name == "Dash":
		$Sprites.modulate = Color(100.0, 100.0, 100.0)
	elif $CompBackpack.is_full():
		$Sprites.modulate = Color.YELLOW
	else:
		$Sprites.modulate = Color.WHITE
		
	
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
	$StateMachine.do_dash()
	
func end_dash():
	$StateMachine/Dash.end_dash_prematurely()
	
func bee_died():
	bee_dies.emit(self)
	
func can_deal_damage() -> bool:
	return $StateMachine.state.name == "Dash"
	


func _on_tree_exiting() -> void:
	manager.bees.erase(self)
	manager.UI.set_bees_amount(manager.get_amount_of_bees())
	manager.cursour_folowing.erase(self)
	manager.dashing_bees.erase(self)
	
