extends Area2D

@onready var canPurchase = false
@export var hotCocoaPrice = 5

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
			#print("purchased!")
			Global.coinTotal -= 5
			Global.hotCocoa += 1
			#print(Global.hotCocoa)
	elif canPurchase && Global.coinTotal < hotCocoaPrice:
		if Input.is_action_just_released("interact"):
			print("sorry you don't have enough money")
