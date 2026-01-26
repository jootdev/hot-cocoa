extends Area2D

@onready var audioPlayer = $AudioStreamPlayer2D

func _on_body_entered(body):
	if body.name == "player":
		queue_free()
