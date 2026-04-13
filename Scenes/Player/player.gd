extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var score: int = 200
	var money: float = 15.5
	var username: String = "Bob"
	var is_player_alive: bool= true
	var first_name: String = "Márk"
	var damage: float = 7.5
	
	score = 20
	
	print(score + 200 - 100 * score)
	print(username)
	print(is_player_alive)
	print(first_name)
	print(damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
