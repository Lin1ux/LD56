extends Node

var player_pollens : int = 0
var total_pollen: int = 0
signal value_changed(pollens : int)


func add_pollen(amount : int):
	player_pollens+=amount
	total_pollen+=amount
	value_changed.emit(total_pollen)
	
func remove_pollen(amount : int):
	player_pollens-=amount
	value_changed.emit(total_pollen)
	
func set_pollen(amount : int):
	player_pollens = amount
	value_changed.emit(total_pollen)
	
func get_pollen():
	return player_pollens
	
