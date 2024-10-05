extends Control

@export var bees_info : Control ##Bee infos
@export var pollen_info : Control ##pollen infos

func _ready():
	PollenManager.value_changed.connect(set_pollen_amount)

func set_bees_amount(amount : int):
	bees_info.set_text(str(amount))
	
func set_pollen_amount(amount : int):
	pollen_info.set_text(str(amount))

func get_bees_info():
	return bees_info
	
func get_pollen_info():
	return pollen_info
