extends RigidBody2D


var direction : Vector2
@export var acceleration : float = 10

@export var max_speed : float = 4

var direction_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	custom_integrator = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _integrate_forces(state : PhysicsDirectBodyState2D):
	var ratio = 1
	if direction.dot(state.linear_velocity) < 0.25:
		ratio = 0.1
	
	state.apply_impulse(direction * acceleration * ratio)
	
	
	
	if state.linear_velocity.length() > max_speed:
		var dir = state.linear_velocity.normalized()
		state.linear_velocity = dir * max_speed
	
	
	
func _physics_process(delta):
	if direction_tween:
		direction_tween.kill()
		
		
		
	var new_direction = (get_global_mouse_position() - position).normalized()
	
	
	
	direction_tween = create_tween()
	direction_tween.tween_property(self,"direction",new_direction,0.4)
	direction_tween.set_trans(Tween.TRANS_QUAD)	
		
	
	
	
