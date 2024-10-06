class_name Hive
extends Node2D

@export var bee_controller : Node ##controler to manage bees
@export var update_pollen : bool ##Is hive update pollens after spawning bee 


func get_bee_controller():
	return bee_controller
	
func get_update_pollen():
	return update_pollen
	
