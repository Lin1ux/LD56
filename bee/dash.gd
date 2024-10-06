extends Node

@onready var bee = $"../.."
@onready var state_machine = $".."

@export var minimal_dash_time_remaining = 0.3
@export var dash_time : float = 0.7
var current_time 
func enter():
	current_time = dash_time
	
func exit():
	pass
	
func update(delta):
	current_time -= delta
	if current_time <=0 :
		state_machine.change_state("FlyTowards")
	
		
		
func end_dash_prematurely():
		current_time = min(current_time,minimal_dash_time_remaining)
