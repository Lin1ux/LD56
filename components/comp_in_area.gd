extends Node2D

@export var component : Node 		##Component where is function
@export var function_name : String	##Name of function to call
@export var has_argument : bool  	##Is function requires trigger

var function : Callable
#@export var Area : Area2D 

func _ready():
	function = Callable(component, function_name)


func in_area(trigger : Node):
	print("In Area")
	if has_argument:
		function.call(trigger)
		return
	function.call()
