extends Node

var player_pollens : int = 0
signal value_changed(pollens : int)


func add_pollen(amount : int):
	player_pollens+=amount
	value_changed.emit(player_pollens)
	
func remove_pollen(amount : int):
	player_pollens-=amount
	value_changed.emit(player_pollens)
	
func set_pollen(amount : int):
	player_pollens = amount
	value_changed.emit(player_pollens)
	
func get_pollen():
	return player_pollens
	
