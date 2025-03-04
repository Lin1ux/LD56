extends Node2D

@export_group("Bees")
@export var bee_prefab : PackedScene
@export var bees_to_spawn : int

@export_group("Other")
@export var UI : Node

@export var BEE_LIMIT: int = 50

@export var bees_ratio: float = 0.5

@onready var bees_holder = $Bees

var bees : Array[BeeControler]

@export var cursor: Node

var cursour_folowing : Array[BeeControler]

var number_of_bees : int


func _ready():
	Watcher.add_watched_variable(self,"number_of_bees")
	Watcher.add_watched_variable(self,"x")
	number_of_bees = len(bees)
	spawn_bees(Vector2.ZERO, bees_to_spawn)
	Console.add_comand("spawnbees",spawn_bees, ["vector2","int"])
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			start_dash()
		if event.button_index == 1 and event.canceled:
			end_dash()


var dashing_bees : Array[BeeControler]

func sort_by_distance_to_cursor(a: Node2D, b: Node2D):
	return a.global_position.distance_to(get_global_mouse_position()) < b.global_position.distance_to(get_global_mouse_position())

func get_dash_cooldown():
	return $DashCooldown.time_left / $DashCooldown.wait_time

func start_dash():
	# Quit if dash not cooled down
	if get_dash_cooldown() > 0:
		return
	
	var bees_count = len(cursour_folowing)
	var arr : Array = range(bees_count)
	
	cursour_folowing.sort_custom(sort_by_distance_to_cursor)
	var bees_to_dash = ceil(bees_count * bees_ratio)
	
	if bees_to_dash > 0:
		
		$DashSound.play()
		cursor.target_effect()
		$DashCooldown.start()
		
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
	

var x: float
func _process(delta):
	
	for bee in bees:
		if bee != null:
			bee.provide_new_target_location(get_global_mouse_position())

func spawn_bees(location : Vector2 = Vector2.ZERO, count : int = 5):

	for i in range(count):
		
		if bees.size() >= BEE_LIMIT:
			var combined_bee = bees.pick_random()
			combined_bee.get_node("CompHP").max_hp += 1
			combined_bee.get_node("CompHP").hp += 1
		else:
			var bee :BeeControler= bee_prefab.instantiate()
			bees.append(bee)
			cursour_folowing.append(bee)
			bee.position = location
			bee.new_target(location)
			bee.bee_dies.connect(destroy_bee,ConnectFlags.CONNECT_ONE_SHOT)
			bees_holder.add_child(bee)
			bee.manager = self
		
	if UI:
		UI.set_bees_amount(get_amount_of_bees())
		
	return "spawned bees"
		
func get_amount_of_bees():
	var bee_count := 0
	for bee in bees:
		bee_count += bee.get_node("CompHP").hp
	return bee_count
	
func get_random_bee():
	if len(bees)> 0:
		return bees[randi_range(0,len(bees)-1)]
	return null
	
func get_amount_of_pollen():
	var sum = 0
	for i in bees:
		sum += i.get_backpack().get_pollen_amount()
	return sum



func destroy_bee(bee: BeeControler, fatal: bool):
	
	if UI:
		UI.set_bees_amount(get_amount_of_bees())
	
	if fatal:
		
		bees.erase(bee)
		cursour_folowing.erase(bee)
		dashing_bees.erase(bee)
		bee.queue_free()
		
		if len(bees) == 0:
			var callable = Callable(get_tree(),"change_scene_to_file")
			callable.call_deferred("res://end_title.tscn")
