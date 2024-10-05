extends Node2D

@export var component : Node 		##Component where is function
@export var function_name : String	##Name of function to call
@export var has_argument : bool  	##Is function requires trigger
@export var shape :Shape2D 			##Shape of collider

var function : Callable
#@export var Area : Area2D 
#@export var height : float = 8	##Height of area	

func _ready():
	function = Callable(component, function_name)
	$CollisionShape2D.shape = shape
	#$CollisionShape2D.shape.radius = radius
	#.shape.height = height


func in_area(trigger : Node):
	#print("In Area")
	if not component.has_method(function_name):
		return
	if has_argument:
		function.call(trigger)
		return
	function.call()
