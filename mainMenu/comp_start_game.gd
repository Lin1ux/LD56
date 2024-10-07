extends Node2D

@export var start_cost : int = 3 ##how much spawning bee costs
@export var progress_bar : Node ##Progress bar
var number_of_pollen : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	number_of_pollen = 0
	update_progress_bar()

func start_game():
	$"../StartSound".play()
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://world.tscn")
		
func add_pollen(pollens : int):
	if pollens:
		$"../CollectSound".play()
	number_of_pollen += pollens
	update_progress_bar()
	
	if pollens > 0 and number_of_pollen >= start_cost:
		start_game()
	
	
func give_pollen(character : Node):
	#checking is character have backpack component
	if not character.has_method("get_backpack"):
		return
	var backpack = character.get_backpack()
	if backpack == null:
		return
	#moving pollen from backpack to object
	add_pollen(backpack.remove_pollen())
	
func update_progress_bar():
	if progress_bar == null:
		progress_bar.visible = false
		return
	progress_bar.value = number_of_pollen
	progress_bar.max_value = start_cost
