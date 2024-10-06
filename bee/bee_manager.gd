extends Node2D

@export_group("Bees")
@export var bee_prefab : PackedScene
@export var bees_to_spawn : int

@export_group("Other")
@export var UI : Node

@onready var bees_holder = $Bees

var bees : Array[BeeControler]

var selected_bees : Array[BeeControler]


func _ready():
	spawn_bees(Vector2.ZERO, 3)
	

func _process(delta):
	for bee in bees:
		bee.provide_new_target_location(get_global_mouse_position())

func spawn_bees(location : Vector2, count : int):
	for i in range(count):
		var bee :BeeControler= bee_prefab.instantiate()
		bees.append(bee)
		bee.position = location
		bee.new_target(location)
		bees_holder.add_child(bee)
	UI.set_bees_amount(get_amount_of_bees())
		
func get_amount_of_bees():
	return len(bees)
