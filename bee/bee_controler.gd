extends RigidBody2D


var direction : Vector2
@export var acceleration : float = 10

@export var max_speed : float = 4


@export var random_shpere_radius : float = 50



@export var tween_duration: float = 0.2
var direction_tween: Tween

var side_acceleration : float


# Called when the node enters the scene tree for the first time.
func _ready():
	custom_integrator = true

	side_acceleration = randf_range(-1,1)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _integrate_forces(state : PhysicsDirectBodyState2D):
	
	
	
	state.apply_impulse(direction * acceleration)
	
	var side_motion = direction.rotated(deg_to_rad(90))
	state.apply_impulse(side_motion * side_acceleration)
	
	
	if state.linear_velocity.length() > max_speed:
		var dir = state.linear_velocity.normalized()
		state.linear_velocity = dir * max_speed
	
	
	
func _physics_process(delta):
		pass
		
	
	

func new_target(target_position : Vector2):
	if direction_tween:
		direction_tween.kill()
		
	var new_direction = (target_position - position).normalized()

	direction_tween = create_tween()
	direction_tween.tween_property(self,"direction",new_direction,tween_duration)
	direction_tween.set_trans(Tween.TRANS_SPRING)	
	
	
