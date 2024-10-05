extends Node2D

@export var bee_prefab : PackedScene
@export var bees_to_spawn : int

var bees : Array[Bee]

var selected_bees : Array[Bee]


func _ready():
	spawn_bees(Vector2.ZERO, 10)
	



func spawn_bees(location : Vector2, count : int):
	for i in range(count):
		var bee :Bee= bee_prefab.instantiate()
		bees.append(bee)
		bee.position = location
		bee.new_target(location)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for bee in bees:
		bee.new_target(get_global_mouse_position())
