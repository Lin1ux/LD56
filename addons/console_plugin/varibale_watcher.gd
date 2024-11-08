extends Node
class_name VariableWatcher

class WachedVariable:
	extends Object
	var ovner : Object
	var variable : String
	var marked_for_cleanup : bool = false
	var type : Variant.Type
	
	func get_variable():
		if is_instance_valid(ovner):
			return ovner.get(variable)
		else:
			marked_for_cleanup = true
			return "script with watched variable does not exist"
			
	func set_variable(new_value):
		if is_instance_valid(ovner):
			var converted_new_value = convert_value(type,new_value)
			ovner.set(variable,converted_new_value)
			
	func convert_value(convert_type : Variant.Type, value):
		match convert_type:
			Variant.Type.TYPE_INT:
				return int(value)
			Variant.Type.TYPE_STRING:
				return value
			Variant.Type.TYPE_FLOAT:
				return float(value)
			Variant.Type.TYPE_BOOL:
				return value


var watched_variables : Array[WachedVariable]


const WINDOW = preload("res://addons/console_plugin/watcher_window.tscn")
const PROPERTY = preload("res://addons/console_plugin/Variable_field.tscn") 

var window

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_F1 and event.is_pressed():
			print("pressed")
			change_state()


func _ready():
	get_viewport().gui_embed_subwindows = false
	window = WINDOW.instantiate()
	add_child(window)
	window.visible = true
	window.always_on_top = false
	window.position = Vector2(1800,500)
	window.size = Vector2(640,460)
	window.title = "Watcher"
	window.close_requested.connect(window_close_request)
	

func _process(delta):
	pass



func add_watched_variable(ovner : Object, property : String):
	var wv = WachedVariable.new()
	wv.ovner = ovner
	wv.variable = property
	wv.type = typeof(wv.get_variable())
	watched_variables.append(wv)
	var vf :VariableField= PROPERTY.instantiate()
	vf.variable = wv
	
	
	window.get_node("VariableHolder").add_child(vf)

func change_state():
	print("x")
	if window.visible:
		window.visible = false
	else:
		window.show()

func window_close_request():
	window.visible = false;
