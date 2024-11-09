extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = [
		load("res://sprites/prop_grass.png"),
		load("res://sprites/grass2.png"),
		load("res://sprites/grass3.png"),
	].pick_random()
	$Sprite2D.flip_h = bool(randi_range(0,1))
	
	await get_tree().create_timer(randf_range(0.0, 4.0)).timeout
	$AnimationPlayer.play("flow")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$AnimationPlayer.play("flow")
