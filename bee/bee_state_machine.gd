extends Node

@onready var state : Node = $FlyTowards



func _ready():
	pass



func _process(delta):
	state.update(delta)
	
	
func change_state(new_state : String):
	var new = get_node_or_null(new_state)
	if new:
		state.exit()
		state = new
		state.enter()
	else:
		print("coud not find state: " + new_state)
	

func do_dash():
	change_state("Dash")




			
