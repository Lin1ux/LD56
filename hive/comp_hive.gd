extends Node2D

@export var bee_cost : int = 5 ##how much spawning bee costs
@export var parent : Node 	   ##Parent of component	
@export var bee : PackedScene  ##Bee to spawn
@export var progress_bar : Node ##Progress bar
@export var update_pollen : bool 
var number_of_pollen : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	number_of_pollen = 0
	update_progress_bar()
	
func spawn_bees():
	if number_of_pollen >= bee_cost:
		$"../BeeSpawnSound".play()
		print("Bee spawned")
		number_of_pollen -= bee_cost
		parent.get_bee_controller().spawn_bees(parent.global_position, 1)
		#if parent.get_update_pollen:
		#	PollenManager.set_pollen(parent.get_bee_controller().get_amount_of_pollen())

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			parent.get_bee_controller().spawn_bees(parent.global_position, 10)
		
func add_pollen(pollens : int):
	if pollens:
		$"../CollectSound".play()
	number_of_pollen += pollens
	update_progress_bar()
	PollenManager.add_pollen(pollens)
	
	
func give_pollen(character : Node):
	#checking is character have backpack component
	if not character.has_method("get_backpack"):
		return
	var backpack = character.get_backpack()
	if backpack == null:
		return
	#moving pollen from backpack to object
	add_pollen(backpack.remove_pollen())
	spawn_bees()
	
func update_progress_bar():
	if progress_bar == null:
		progress_bar.visible = false
		return
	progress_bar.value = number_of_pollen
	progress_bar.max_value = bee_cost
