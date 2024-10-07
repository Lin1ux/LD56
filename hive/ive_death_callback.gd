extends Node

func death():
	var callable = Callable(get_tree(),"change_scene_to_file")
	callable.call_deferred("res://end_title.tscn")
