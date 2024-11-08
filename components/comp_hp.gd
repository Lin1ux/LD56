extends Node2D

var hp : int
@export var max_hp : int
@export var parent : Node
@export var parent_sprite : Node2D
@export var progress_bar : Node
@export var hitbox : Area2D
@export var vulnerable :  bool = true

@export var hide_bar : bool = false

@export_range(-10, 10) var invincibility_frames : float = 0.5

signal hp_changed(current_hp)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hp = max_hp
	progress_bar.max_value = hp
	progress_bar.value = hp
	
	hitbox.body_entered.connect(got_hit)
	
	$InvincibilityFrames.wait_time = invincibility_frames
	
	return


func got_hit(body: Node2D):
	if not vulnerable:
		return
	if body.has_method("can_deal_damage"):
		if body.can_deal_damage():
			if $InvincibilityFrames.time_left == 0:
				$InvincibilityFrames.start()
				decrease_hp(1)
				if body.has_method("enemy_atacked"):
					body.enemy_atacked()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress_bar.visible = hp != max_hp and not hide_bar
	
	set_global_rotation(0)

func _physics_process(delta: float) -> void:
	if parent_sprite != null:
		if $InvincibilityFrames.time_left > 0:
			parent_sprite.visible = !parent_sprite.visible
		else:
			parent_sprite.visible = true


func get_hp() -> int:
	return hp
	
func get_max_hp() -> int:
	return max_hp

func decrease_hp(value : int):
	hp = hp - value
	hp_changed.emit(hp)
	progress_bar.value = hp
	if hp <= 0:
		death()
	return

func increase_hp(value : int):
	hp = min(hp + value,max_hp)
	hp_changed.emit(hp)
	progress_bar.value = hp
	return


@export var death_callback: Node
func death():
	if death_callback != null:
		death_callback.death()
	else:
		parent.queue_free()
	return
	
func set_vulnerable(mode :bool):
	vulnerable = mode
