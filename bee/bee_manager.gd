extends Node2D

@export_group("Bees")
@export var bee_prefab : PackedScene
@export var bees_to_spawn : int

@export_group("Other")
@export var UI : Node



@export var bees_ratio: float = 0.5

@onready var bees_holder = $Bees

var bees : Array[BeeControler]



var cursour_folowing : Array[BeeControler]


func _ready():
	spawn_bees(Vector2.ZERO, bees_to_spawn)
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			statr_dash()
			$DashSound.play()
		if event.button_index == 1 and event.canceled:
			end_dash()


var dashing_bees : Array[BeeControler]


func statr_dash():
	
	var bees_count = len(cursour_folowing)
	var arr : Array = range(bees_count)
	arr.shuffle()
	var bees_to_dash = ceil(bees_count * bees_ratio)
	
	for i in range(bees_to_dash):
		var dashing_bee = cursour_folowing[arr[i]]
		dashing_bee.dash()
		dashing_bee.dash_finished.connect(dash_cleaup,ConnectFlags.CONNECT_ONE_SHOT)
		dashing_bees.append(dashing_bee)
	for dashing_bee in dashing_bees:
		cursour_folowing.erase(dashing_bee)
	
func dash_cleaup(bee : BeeControler):
	dashing_bees.erase(bee)
	cursour_folowing.append(bee)


func end_dash():
	for bee in dashing_bees:
		bee.end_dash()
		cursour_folowing.append(bee)
	dashing_bees.clear()
	


func _process(delta):
	for bee in bees:
		if bee != null:
			bee.provide_new_target_location(get_global_mouse_position())

func spawn_bees(location : Vector2, count : int):
	for i in range(count):
		var bee :BeeControler= bee_prefab.instantiate()
		bees.append(bee)
		cursour_folowing.append(bee)
		bee.position = location
		bee.new_target(location)
		bee.bee_dies.connect(destroy_bee,ConnectFlags.CONNECT_ONE_SHOT)
		bees_holder.add_child(bee)
		bee.manager = self
	UI.set_bees_amount(get_amount_of_bees())
		
func get_amount_of_bees():
	return len(bees)
	
func get_random_bee():
	return bees[randi_range(0,len(bees)-1)]
	
func get_amount_of_pollen():
	var sum = 0
	for i in bees:
		sum += i.get_backpack().get_pollen_amount()
	return sum


func destroy_bee(bee: BeeControler):
	bees.erase(bee)
	cursour_folowing.erase(bee)
	dashing_bees.erase(bee)
	bee.queue_free()
