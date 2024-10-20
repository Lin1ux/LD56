extends Node


var aveilable_commands ={}

const WINDOW = preload("res://addons/console_plugin/window.tscn")
var text_output : RichTextLabel
var line_edit : LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	var window = WINDOW.instantiate()
	get_viewport().gui_embed_subwindows = false
	add_child(window)
	window.visible = true
	window.position = Vector2(1300,700)
	window.size = Vector2(600,400)
	window.title = "Console"
	text_output = window.get_node("VBoxContainer/RichTextLabel")
	line_edit = window.get_node("VBoxContainer/LineEdit")
	line_edit.connect("text_submitted",process_command)
	add_comand("ls",list_comands)
	
	
	


func process_command(command:String):
	line_edit.clear()
	command = command.to_lower()
	text_output.append_text(command + "\n")
	print(command);
	if command in aveilable_commands:
		var msg = aveilable_commands[command].call()
		if msg:
			text_output.append_text(msg)
	else:
		text_output.append_text("[color=red]command not recognized[/color]\n")



func add_comand(command : String, function : Callable, parameters :int = 0):
	command = command.to_lower()
	if command not in aveilable_commands:
		aveilable_commands[command] = function
		print("command " + command + " added succesfully")
	
		
func list_comands() -> String:	
	var x : String = ""
	for key in aveilable_commands.keys():
		x += key + "\n"
	return x
