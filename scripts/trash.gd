extends Area2D

@export var trashValue = 3
@export var despawnMinValue = 5
@export var despawnMaxValue = 10

@onready var despawnTimer = $Timer
@onready var audioPlayer = $AudioStreamPlayer2D

func _ready():
	despawnTimer.start(randf_range(despawnMinValue,despawnMaxValue))

func _on_body_entered(body):
	if body.name == "player":
		Global.coinTotal -= trashValue
		Global.trashTotal -= 1
		audioPlayer.play()
		await audioPlayer.finished
		queue_free()

func _on_timer_timeout() -> void:
	Global.trashTotal -= 1
	queue_free()
