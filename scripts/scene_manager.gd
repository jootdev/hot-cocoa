class_name SceneManager extends CanvasLayer

signal transitioned_in()
signal transitioned_out()

@onready var animation = $AnimationPlayer
@onready var animatedSprite = $AnimatedSprite2D
@onready var audioPlayer = $AudioStreamPlayer2D
@onready var last_scene_name

var scene_path = "res://scenes/"

func _process(delta: float) -> void:
	pass

func change_scene(from, to_scene_name: String) -> void:
	last_scene_name = from.name
	
	transition_in()
	await transitioned_in
	
	audioPlayer.play()
	
	await get_tree().create_timer(3.0).timeout
	
	var full_path = scene_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	
	transition_out()
	await transitioned_out
	
	audioPlayer.stop()
	
func transition_in() -> void:
	animation.play("as_in")
	#animatedSprite.visible = true
	
func transition_out() -> void:
	animation.play("as_out")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "as_in":
		transitioned_in.emit()
	elif anim_name == "as_out":
		transitioned_out.emit()
