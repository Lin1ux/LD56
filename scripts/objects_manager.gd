extends Node2D

@export var Objects : Node
var flower_list : Array[Flower]
var hive_list : Array[Hive]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in Objects.get_children():
		if i is Flower:
			flower_list.append(i)
		if i is Hive:
			hive_list.append(i)

func get_random_flower():
	return flower_list[randi_range(0,len(flower_list)-1)]
	
func add_flower(new_flower : Flower):
	flower_list.append(new_flower)
	
func add_new_child(new_child : Node):
	$Objects.add_child(new_child)
