extends Node2D
class_name BeeControler



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




	
func _integrate_forces(state : PhysicsDirectBodyState2D):
	
	
	
	state.apply_impulse(direction * acceleration)
	
	var side_motion = direction.rotated(deg_to_rad(90))
	state.apply_impulse(side_motion * side_acceleration)
	
	
	if state.linear_velocity.length() > max_speed:
		var dir = state.linear_velocity.normalized()
		state.linear_velocity = dir * max_speed
	
	$Sprite2D.look_at(state.linear_velocity.rotated(PI/2))
	
	
	
func _physics_process(delta):
		
		
	if $CompBackpack.is_full():
		$Sprite2D.modulate = Color.YELLOW
	else:
		$Sprite2D.modulate = Color.WHITE
		
	
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
