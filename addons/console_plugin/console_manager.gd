@tool
extends EditorPlugin



func _enable_plugin():
	add_autoload_singleton("Console","res://addons/console_plugin/console.gd")
