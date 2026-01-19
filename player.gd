extends CharacterBody2D

@onready var sprite := $Sprite2D
const SPEED = 450.0

func get_input():
	var direction := Input.get_vector("left", "right", "up", "down")
	
	if direction.x < 0:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
