extends Node2D

@export var component : Node
@export var function_name : String

var function : Callable
#@export var Area : Area2D 

func _ready():
	function = Callable(component, function_name)


func in_area():
	print("In Area")
	function.call()
