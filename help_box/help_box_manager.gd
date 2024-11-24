extends Node2D

var help_box = preload("res://help_box/help_box.tscn")

func show_help(title, description, icon):
	var hb = help_box.instantiate()
	hb.set_title(title)
	hb.set_description(description)
	hb.set_icon(icon)
	
	var root_nodes = get_tree().get_root().get_children()
	for rn in root_nodes:
		if rn is World or rn is Menu:
			rn.add_child(hb)
			break
