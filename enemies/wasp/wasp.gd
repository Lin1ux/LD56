extends CharacterBody2D


@export var speed : float = 20.0
@export var hive : Node2D

@export var zigzag_offset: int = 0

func _physics_process(delta: float) -> void:
	var distance := (hive.global_position - self.get_position())
	velocity = distance.normalized() * speed
	
	if distance.length() > 50:
		velocity += Vector2.UP.rotated(global_rotation) * sin(deg_to_rad(zigzag_offset)) * 50
		zigzag_offset += 4
	
	look_at(velocity)
	move_and_slide()


func can_deal_damage()-> bool:
	return true

func enemy_atacked():
	queue_free()
	
