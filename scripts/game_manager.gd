extends Node

const COIN_SCENE = preload("res://scenes/world/coin.tscn")
const TRASH_SCENE = preload("res://scenes/world/trash.tscn")

@onready var coinLabel = get_node("coinLabel")
@onready var hotCocoaLabel = get_node("hotCocoaLabel")
@onready var spawnTimer = $Timer
@onready var audioPlayer = $AudioStreamPlayer2D
@onready var isCoin := false

@export var minTime = 5
@export var maxTime = 10
@export var spawn_radius = 200

func _ready():
	coinLabel.text = "COIN: " + str(Global.coinTotal)
	hotCocoaLabel.text = "HOT COCOA: "+ str(Global.hotCocoa)
	spawnTimer.start(randf_range(minTime, maxTime))
	
func _process(delta: float) -> void:
	coinLabel.text = "COIN: " + str(Global.coinTotal)
	hotCocoaLabel.text = "HOT COCOA: "+ str(Global.hotCocoa)
	
	if get_tree().current_scene.name == "world":
		if !isCoin:
			spawn_coin(COIN_SCENE)
			isCoin = true
		
		if !get_node("Coin"):
			add_point()
			audioPlayer.stream = load("res://audio/coin.wav")
			audioPlayer.play()
			isCoin = false
	
### World Functions ###
func add_point():
	Global.coinTotal += 1
		
func spawn_coin(COIN_SCENE):
	var player = get_node("/root/world/player")
	var player_pos = player.global_position
	
	var spawn_pos: Vector2
	var attempts = 0
	const MAX_ATTEMPTS = 20
	
	# logic to make sure it doesn't spawn on top
	while attempts < MAX_ATTEMPTS:
		spawn_pos = random_spawn_position()
		
		if player_pos.distance_to(spawn_pos) >= spawn_radius:
			print("COIN IS TOO CLOSE")
			break
			
		attempts += 1
		
	if attempts == MAX_ATTEMPTS:
		return
		
	var coin = COIN_SCENE.instantiate()
	coin.global_position = spawn_pos
	add_child(coin)
	
func spawn_trash(TRASH_SCENE):
	if get_tree().current_scene.name == "world":
		var player = get_node("/root/world/player")
		var player_pos = player.global_position
		
		var spawn_pos: Vector2
		var attempts = 0
		const MAX_ATTEMPTS = 20

		while attempts < MAX_ATTEMPTS:
			spawn_pos = random_spawn_position()
			
			if player_pos.distance_to(spawn_pos) >= spawn_radius:
				print("TRASH IS TOO CLOSE")
				break
				
			attempts += 1
			
		if attempts == MAX_ATTEMPTS:
			return
			
		var trash = TRASH_SCENE.instantiate()
		trash.global_position = spawn_pos
		add_child(trash)
	else:
		return

func _on_timer_timeout() -> void:
	if Global.trashTotal < 3:
		spawn_trash(TRASH_SCENE)
		spawnTimer.start()
		Global.trashTotal += 1

func random_spawn_position():
	return Vector2(
		randf_range(250, 950),
		randf_range(300, 650)
	)
	
	#scene.global_position = Vector2(randf_range(250,950),randf_range(300, 650))
	#return scene.global_position
	
	
