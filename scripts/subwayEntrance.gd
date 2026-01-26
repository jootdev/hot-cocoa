extends Area2D

@onready var touchDoor = false

func _process(delta: float) -> void:
	get_input()

func _on_body_entered(body):
	if body.name == "player":
		touchDoor = true
		
		if get_owner().name == "world" || "market":
			$Sprite2D.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		touchDoor = false
		
		if get_tree().current_scene.name == "world" || "market":
			$Sprite2D.visible = false

func get_input():
	if touchDoor:
		if Input.is_action_pressed("interact"):
			if get_owner().name == "world":
				scene_manager.change_scene(get_owner(), "market")
			if get_owner().name == "market":
				scene_manager.change_scene(get_owner(), "world")
