extends CharacterBody2D

@export var speed : int = 300 			##speed of bird
@export var max_hp : int = 10 			##max amount of hp
@export var rotation_speed : float = 100 	##how fast bird rotates

func get_speed():
	return speed
	
func get_rotation_speed():
	return rotation_speed
	
func get_max_hp():
	return max_hp
