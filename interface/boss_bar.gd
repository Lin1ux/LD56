extends TextureProgressBar

@export var max_hp : int = 100
var creature_name : String = "Enemy"
var current_hp : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_hp = max_hp
	set_new_name(creature_name)
	
func set_max_hp(new_value : int):
	max_hp = new_value
	current_hp = max_hp
	update_bar()

func update_hp(new_hp : int):
	current_hp = new_hp
	update_bar()

func update_bar():
	value = current_hp
	max_value = max_hp
	
func set_new_name(new_name : String):
	creature_name = new_name
	$Label.text = creature_name
	
func show_bar(mode : bool):
	visible = mode
