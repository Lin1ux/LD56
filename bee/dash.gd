extends Node

@onready var bee = $"../.."
@onready var state_machine = $".."


@export var dash_time : float = 3
var current_time 
func enter():
	current_time = dash_time
	
func exit():
	pass
	
func update(delta):
	current_time -= delta
	if current_time <=0 :
		state_machine.change_state("FlyTowards")
	
		
		
