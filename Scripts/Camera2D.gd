extends Camera2D

@export var player : Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = player.position
