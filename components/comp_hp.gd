extends Node

var hp : int
@export var max_hp : int
@export var parent : Node
@export var progress_bar : Node
@export var hitbox : Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hp = max_hp
	progress_bar.max_value = hp
	progress_bar.value = hp
	
	hitbox.area_entered.connect(got_hit)
	
	return


func got_hit(area: Area2D):
	
	decrease_hp(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_hp() -> int:
	return hp

func decrease_hp(value : int):
	hp = hp - value
	progress_bar.value = hp
	if hp <= 0:
		death()
	return

func increase_hp(value : int):
	hp = min(hp + value,max_hp)
	progress_bar.value = hp
	return
	
func death():
	parent.queue_free()
	return
	
