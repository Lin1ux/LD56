extends CharacterBody2D

@export var speed : float = 200 ## How fas bullet moves

func _ready():
	$Timer.start()

func _process(delta):
	self.velocity = fly_forward(delta)
	move_and_slide()

func fly_forward(delta: float):
	return Vector2.RIGHT.rotated(self.rotation) * speed * delta * 100

func set_pos(pos : Vector2):
	position = pos

func set_rot(rot : float):
	self.rotation = rot

func _on_timer_timeout() -> void:
	self.queue_free()
