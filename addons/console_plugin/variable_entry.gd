extends HBoxContainer
class_name VariableField
var variable : VariableWatcher.WachedVariable
var refresh_value : bool = true




func _process(delta):
	if refresh_value:
		%value.text = str(variable.get_variable())
		

func _ready():
	%name.text = variable.variable

func _on_value_text_submitted(new_text):
	variable.set_variable(new_text)
	refresh_value = true
	


func _on_value_focus_entered():
	refresh_value = false


func _on_value_focus_exited():
	refresh_value = true
