extends Node

@export var hp : int
@export var parent : Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_hp() -> int:
	return hp

func decrease_hp(value : int):
	hp = hp - value
	if hp <= 0:
		death()
	return

func increase_hp(value : int):
	hp = hp + value
	return
	
func death():
	parent.queue_free()
	return
	
