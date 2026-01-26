extends Area2D

@onready var canPurchase = false
@onready var audioPlayer = $AudioStreamPlayer2D
@export var hotCocoaPrice: int

const noMoneySound = preload("res://audio/broke.wav")
const hotCocoaSound = preload("res://audio/hotcocoav2.wav")	

func _process(delta: float) -> void:
	get_input()

func _on_body_entered(body):
	if body.name == "player":
		canPurchase = true
		$Sprite2D.visible = true
		print("hello, how are you!")
		
func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		canPurchase = false
		$Sprite2D.visible = false

func get_input():
	if canPurchase && Global.coinTotal >= hotCocoaPrice:
		if Input.is_action_just_released("interact"):
			Global.coinTotal -= hotCocoaPrice
			Global.hotCocoa += 1
			audioPlayer.stream = hotCocoaSound
			audioPlayer.play()
	elif canPurchase && Global.coinTotal < hotCocoaPrice:
		if Input.is_action_just_released("interact"):
			print("sorry you don't have enough money")
			audioPlayer.stream = noMoneySound
			audioPlayer.play()
