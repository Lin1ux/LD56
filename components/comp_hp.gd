extends Node

var hp : int
@export var max_hp : int
@export var parent : Node
@export var parent_sprite : Node2D
@export var progress_bar : Node
@export var hitbox : Area2D

@export_range(-10, 10) var invincibility_frames : float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	hp = max_hp
	progress_bar.max_value = hp
	progress_bar.value = hp
	
	hitbox.body_entered.connect(got_hit)
	
	$InvincibilityFrames.wait_time = invincibility_frames
	
	return


func got_hit(body: Node2D):
	if body.has_method("can_deal_damage"):
		if body.can_deal_damage():
			if $InvincibilityFrames.time_left == 0:
				$InvincibilityFrames.start()
				decrease_hp(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if $InvincibilityFrames.time_left > 0:
		parent_sprite.visible = !parent_sprite.visible


func get_hp() -> int:
	return hp

func decrease_hp(value : int):
	hp = hp - value
	progress_bar.value = hp
	if hp <= 0:
		death()
	return

func increase_hp(value : int):
	hp = min(hp + value,max_hp)
	progress_bar.value = hp
	return
	
func death():
	parent.queue_free()
	return
	
