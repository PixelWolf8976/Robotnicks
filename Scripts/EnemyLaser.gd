extends CharacterBody2D

@export var speed = 700.0

func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)
	set_collision_mask_value(2, false)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
