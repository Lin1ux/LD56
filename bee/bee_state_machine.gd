extends Node

@onready var state : Node = $FlyTowards



func _ready():
	pass



func _process(delta):
	state.update(delta)
