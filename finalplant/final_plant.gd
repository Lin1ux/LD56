extends Enemy

enum actions {DEFENCE,SHOT,MELEE} 
@export var bee_manager : Node				##Bee manager to pick target from
@export var range : float 					##How far can it go 
var start_pos : Vector2
var target : BeeControler
var next_action

func _ready():
	start_pos = self.global_position

func get_target():
	return target
	
func get_new_target():
	target = bee_manager.get_random_bee()
	return target
	
func _process(delta):
	pass
	
func change_action():
	#next_action = actions.MELEE
	next_action = randi_range(0,2)
	print("Next Action")
	return next_action

func get_action():
	return next_action

func get_start_pos():
	return start_pos
	
func should_fall_back():
	return start_pos.distance_squared_to(self.global_position) > range*range
