extends Node


var aveilable_commands ={}

const WINDOW = preload("res://addons/console_plugin/console_window.tscn")


var text_output : RichTextLabel
var line_edit : LineEdit
var window : Window

class function_data:
	var function : Callable
	var types : Array[String]


func change_window_state():
	window.visible = ! window.visible
	get_tree().paused = true
	if window.visible:
		line_edit.grab_focus()

func window_closed():
	get_tree().paused = false


func _input(event):
	if event is InputEventKey:
		if event.key_label == KEY_QUOTELEFT and event.is_pressed():
			change_window_state()
	


# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_viewport().gui_embed_subwindows = false
	window = WINDOW.instantiate()
	add_child(window)
	window.visible = true
	window.always_on_top = true
	window.position = Vector2(1500,500)
	window.size = Vector2(640,460)
	window.title = "Console"
	text_output = window.get_node("VBoxContainer/RichTextLabel")
	line_edit = window.get_node("VBoxContainer/LineEdit")
	window.visible = false
	line_edit.connect("text_submitted",process_command)
	line_edit.closing.connect(window_closed)
	
	
	
	
	
	add_comand("ls",list_comands)
	add_comand("clear",clear)
	
	
	
	
	
	

func parse_parameter(type : String, value : String= ""):
	if type == "vector2":
		var new_string: String = value
		new_string = new_string.erase(0, 1)
		new_string = new_string.erase(new_string.length() - 1, 1)
		var array: Array = new_string.split(",")

		return Vector2(float(array[0]), float(array[1]))
	elif type == "float":
		return float(value)
	elif type == "int":
		return int(value)
	elif type == "string":
		return value
		
		


func call_function(function : function_data, parameters) -> String:
	var argv : Array
	for i in range(1,len(parameters)):
		argv.append(parse_parameter(function.types[i-1],parameters[i]))
	var msg  = function.function.callv(argv)
	if msg:
		return msg
	else:
		return ""
	
	
	
	

func process_command(command:String):
	line_edit.clear()
	command = command.to_lower()
	var words  = command.split(" ",false)
	
	
	text_output.append_text(command + ">\n")
	print(command);
	if words[0] in aveilable_commands:
		var msg = call_function(aveilable_commands[words[0]],words)
		if msg:
			text_output.append_text(msg)
	else:
		text_output.append_text("[color=red]command " +words[0] + " not recognized[/color]\n")



func add_comand(command : String, function : Callable, parameters :Array[String] = []):
	command = command.to_lower()
	var data : function_data = function_data.new()
	data.function = function
	data.types = parameters.duplicate()
	
	
	aveilable_commands[command] = data
	print("command " + command + " added succesfully")
	
		
func list_comands() -> String:	
	var x : String = "-----------\n"
	for key in aveilable_commands.keys():
		x += key + "\n"
	x+= "-----------\n"
	return x
	
func clear()->String:
	text_output.clear()
	return ""
