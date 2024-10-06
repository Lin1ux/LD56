extends Node2D

@export_group("Bees")
@export var bee_prefab : PackedScene
@export var bees_to_spawn : int

@export_group("Other")
@export var UI : Node



@export var bees_ratio: float = 0.5

@onready var bees_holder = $Bees

var bees : Array[BeeControler]

var selected_bees : Array[BeeControler]


func _ready():
	spawn_bees(Vector2.ZERO, 3)
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			statr_dash()
		if event.button_index == 1 and event.canceled:
			end_dash()


var dashing_bees : Array[BeeControler]


func statr_dash():
	
	var bees_count = len(bees)
	var arr : Array = range(bees_count)
	arr.shuffle()
	var bees_to_dash = ceil(bees_count * bees_ratio)
	
	for i in range(bees_to_dash):
		var dashing_bee = bees[arr[i]]
		dashing_bee.dash()
		dashing_bees.append(dashing_bee)
	

func end_dash():
	for bee in dashing_bees:
		bee.end_dash()
	dashing_bees.clear()
	


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
	
func get_amount_of_pollen():
	var sum = 0
	for i in bees:
		sum += i.get_backpack().get_pollen_amount()
	return sum
