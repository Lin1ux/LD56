extends Enemy

enum actions {DEFENCE,SHOT,MELEE} 
@export var bee_manager : Node				##Bee manager to pick target from
var target : BeeControler
var next_action

func get_target():
	return target
	
func get_new_target():
	target = bee_manager.get_random_bee()
	return target
	
func change_action():
	next_action = actions.SHOT
	return next_action

func get_action():
	return next_action
