extends CharacterBody2D


@export var speed : float = 20.0
@export var hive : Node2D

func _physics_process(delta: float) -> void:
	look_at(hive.global_position)
	velocity.x = -sign(self.get_position().x - hive.global_position.x) * speed
	velocity.y =  -sign(self.get_position().y - hive.global_position.y) * speed
	move_and_slide()
