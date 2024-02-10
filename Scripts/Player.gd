extends CharacterBody2D

@export var speed = 150.0
@export var maxStamina = 100.0
@export var staminaDeplete = 20.0
@export var staminaRechargeSecWait = 5.0
@export var staminaRecharge = 50.0
@export var reloadRate = 0.5
@export var bullet = preload("res://Objects/PlayerLaser.tscn")

var stamina = maxStamina
var staminaBeingUsed = false
var staminaTimer = 0.0
var reloadTimer = 0.0

func getInput(delta):
	var inputDir = Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
	if Input.is_action_pressed("Player Sprint") && stamina > 0:
		velocity = inputDir * (speed * 2)
		if stamina > 0:
			stamina -= staminaDeplete * delta
		elif stamina < 0:
			stamina = 0
		
		staminaTimer = 0.0
		staminaBeingUsed = true
	else:
		velocity = inputDir * speed
		staminaBeingUsed = false
	
	if !staminaBeingUsed && stamina != maxStamina && (staminaTimer >= staminaRechargeSecWait):
		stamina += staminaRecharge * delta
		if stamina > maxStamina:
			stamina = maxStamina
	elif !staminaBeingUsed && stamina != maxStamina:
		staminaTimer += delta
	
	var rotat = get_global_mouse_position() - global_position
	if rotat.length() > 10:
		rotation = rotat.angle()
	
	if Input.is_action_pressed("Shoot"):
		reloadTimer += delta
		if reloadTimer >= reloadRate:
			reloadTimer = 0.0
			var b = bullet.instantiate()
			b.start($Muzzle.global_position, rotation)
			get_tree().root.add_child(b)
		else:
			reloadTimer += delta

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_mask_value(1, false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	getInput(delta)
	move_and_slide()
	pass
