extends CharacterBody2D

@onready var sprite := $Sprite2D
@export var SPEED = 450.0

func get_input():
	var direction := Input.get_vector("left", "right", "up", "down")
	var flipped := false
	
	if Input.is_action_pressed("left"):
		flipped = true
	elif Input.is_action_pressed("right"):
		flipped = false
	
	if direction.x < 0 && flipped:
		sprite.flip_h = false
	elif direction.x > 0 && !flipped:
		sprite.flip_h = true
	
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
