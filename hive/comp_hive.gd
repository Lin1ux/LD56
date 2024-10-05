extends Node2D

@export var bee_cost : int = 5 ##how much spawning bee costs
@export var parent : Node 	   ##Parent of component	
@export var bee : PackedScene  ##Bee to spawn
var number_of_pollen : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	number_of_pollen = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn_bees():
	if number_of_pollen > bee_cost:
		print("Bee spawned")
		number_of_pollen -= bee_cost
		
		
func add_pollen(pollens : int):
	number_of_pollen += pollens
	
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
	
