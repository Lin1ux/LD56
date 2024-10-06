extends Node

@export var state : Node	##first state



func _ready():
	state.enter()

func _process(delta):
	state.update(delta)
	
	
func change_state(new_state : String):
	print("state: ",new_state)
	var new = get_node_or_null(new_state)
	if new:
		state.exit()
		state = new
		state.enter()
	else:
		print("coud not find state: " + new_state)
	
			
