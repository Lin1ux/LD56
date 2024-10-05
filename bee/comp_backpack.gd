extends Node2D

@export var max_pollen_amount : int = 1 ##limit of pollens which can be carried
var pollen_amount : int = 0

func is_full():
	return max_pollen_amount <= pollen_amount

func get_pollen_amount():
	return pollen_amount
	
func increase_pollen(amount : int):
	if max_pollen_amount > pollen_amount:
		pollen_amount += amount
	if pollen_amount > max_pollen_amount:
		pollen_amount = max_pollen_amount
		
func decrease_pollen(amount : int):
	pollen_amount -= amount
	if pollen_amount < 0:
		pollen_amount = 0

#remove pollens and returns value before cleaning up	
func remove_pollen():
	var pollens = pollen_amount
	pollen_amount = 0
	return pollens
	
