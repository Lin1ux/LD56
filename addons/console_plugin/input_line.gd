extends LineEdit

signal closing

func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_QUOTELEFT and event.is_pressed():
			$"../..".visible = false
			closing.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
