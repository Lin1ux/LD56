extends Enemy

@export var bee_manager : Node				##Bee manager to pick target from
@export var after_dash_range : float = 50	##how close unit have to be to change dash state
@export var correction : float = 0.4		##how often dash have correction
var target : BeeControler

func _process(delta: float) -> void:
	$CompHP.rotation = -$Sprite2D.global_rotation + PI/2

func get_target():
	return target
	
func get_new_target():
	target = bee_manager.get_random_bee()
	return target
	
func get_after_dash_range():
	return after_dash_range
	
func after_dash_range_sqr():
	return after_dash_range * after_dash_range

func get_correction():
	return correction

func can_deal_damage():
	return true
