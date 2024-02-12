extends Control

var bar

# Called when the node enters the scene tree for the first time.
func _ready():
	bar = $TextureProgressBar
	var playerMaxStamina = $"../../Player".maxStamina
	bar.max_value = playerMaxStamina
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_stamina_changed(playerStamina):
	bar.value = playerStamina
	pass # Replace with function body.
