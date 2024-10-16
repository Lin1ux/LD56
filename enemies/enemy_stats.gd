extends Node
class_name Enemy

@export var enemy_name : String				##Creature's name
@export var speed : int = 100 				##speed of enemy
@export var max_hp : int = 10 				##max amount of hp
@export var rotation_speed : float = 100 	##how fast enemy rotates
@export var engage_range : float = 1000		##how far unit have to be engage target
@export var backpack : Node 				##backpack component


func get_speed():
	return speed
	
func get_rotation_speed():
	return rotation_speed
	
func get_max_hp():
	return max_hp
	
func get_backpack():
	return backpack
	
func get_engage_range():
	return engage_range
	
func engage_range_sqr():
	return engage_range * engage_range
