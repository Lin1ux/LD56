extends Node

@onready var bee = $"../.."
@onready var state_machine = $".."


@export var dash_time : float = 3
var current_time 
func enter():
	current_time = dash_time
	$"../../ParticleTrail".emitting = true
	
func exit():
	$"../../ParticleTrail".emitting = false
	
func update(delta):
	current_time -= delta
	if current_time <=0 :
		state_machine.change_state("FlyTowards")
	
	$"../../ParticleTrail".process_material.direction = Vector3($"../..".linear_velocity.x, $"../..".linear_velocity.y, 0.0)
