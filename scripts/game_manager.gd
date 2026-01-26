extends Node



const coinScene = preload("res://scenes/world/coin.tscn")

@onready var coinLabel = get_node("coinLabel")
@onready var hotCocoaLabel = get_node("hotCocoaLabel")
@onready var isCoin := false

func _ready():
	coinLabel.text = "COIN: " + str(Global.coinTotal)
	hotCocoaLabel.text = "HOT COCOA: "+ str(Global.hotCocoa)
	
func _process(delta: float) -> void:
	coinLabel.text = "COIN: " + str(Global.coinTotal)
	hotCocoaLabel.text = "HOT COCOA: "+ str(Global.hotCocoa)
	
	if get_tree().current_scene.name == "world":
		if !isCoin:
			spawn_coin(coinScene)
			isCoin = true
		
		if !get_node("Coin"):
			add_point()
			isCoin = false
	
### World Functions ###
func add_point():
	Global.coinTotal += 1
		
func spawn_coin(coinScene):
	#print("spawn coin")
	var coin = coinScene.instantiate()
	add_child(coin)
	coin.global_position = Vector2(randf_range(250,950),randf_range(300, 650))
	#print("added node: ", coin.name)
