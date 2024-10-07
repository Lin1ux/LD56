extends Node

@onready var bee = $"../.."
@onready var state_machine = $".."

@export var minimal_dash_time_remaining = 0.3
@export var dash_time : float = 0.7
var current_time 
func enter():
	bee.dash_started = true
	current_time = dash_time
	$"../../ParticleTrail".emitting = true
	
func exit():
	bee.dashing = false
	bee.dash_finished.emit(bee)
	$"../../ParticleTrail".emitting = false
	
func update(delta):
	current_time -= delta
	if current_time <=0 :
		state_machine.change_state("FlyTowards")
	$"../../ParticleTrail".process_material.direction = Vector3($"../..".linear_velocity.x, $"../..".linear_velocity.y, 0.0)
	$"../../ParticleTrail".process_material.color = Color(100.0, 100.0, 100.0)
	
		
		
func end_dash_prematurely():
	current_time = min(current_time,minimal_dash_time_remaining)
