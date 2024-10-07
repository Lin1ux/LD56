extends Enemy

@export var object_manager: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_target():
	return object_manager.get_node("hive")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
