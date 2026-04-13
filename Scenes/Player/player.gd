extends CharacterBody2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		print("You're pressing right")
	if Input.is_action_pressed("move_left"):
		print("You're pressing left")
