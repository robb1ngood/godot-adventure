extends CharacterBody2D

var target: Node2D

func _physics_process(delta):
	if target:
		pass

func _on_player_detect_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
