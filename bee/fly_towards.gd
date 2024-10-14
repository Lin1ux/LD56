extends Node

@onready var bee = $"../.."
const REDIRECT_DISTANCE = 25
const NEW_POSITION_DISTANCE = 250


var final_position : Vector2
var target_location : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	enter()

func exit():
	pass

func enter():
	set_new_destination()

func update(_delta : float):
	if final_position.distance_squared_to(bee.position) < REDIRECT_DISTANCE:
		#print("to close to the coursor")
		enter()
	if target_location.distance_squared_to(final_position) > NEW_POSITION_DISTANCE:
		enter()
	
	
func set_new_destination():
	var offset = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()* 50
	final_position = target_location + offset
	bee.new_target(final_position)
	
func set_new_target_location(location : Vector2):
	target_location = location
	
