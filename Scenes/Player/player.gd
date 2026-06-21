extends CharacterBody2D
class_name Player

@export var move_speed: float = 100
@export var push_strength: float = 10

func _ready():
	update_treasure_label()
	update_hp_bar()
	if SceneManager.player_spawn_position != Vector2(0, 0):
		position = SceneManager.player_spawn_position

func _physics_process(delta):
	move_player()
	push_block()
	update_treasure_label()
	if Input.is_action_just_pressed("interact"):
		attack()
	move_and_slide()
	
func move_player():
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_right")
		$InteractArea2D.position = Vector2(5, 2)
		
	elif velocity.x < 0:
		$AnimatedSprite2D.play("move_left")
		$InteractArea2D.position = Vector2(0-5, 2)
		
	elif velocity.y < 0:
		$AnimatedSprite2D.play("move_up")
		$InteractArea2D.position = Vector2(0, -4)
		
	elif velocity.y > 0:
		$AnimatedSprite2D.play("move_down")
		$InteractArea2D.position = Vector2(0, 8)
		
	else: 
		$AnimatedSprite2D.stop()
		
func push_block():
	
	# Get the last collision
	# Check if it's the block
	# If it is the block, push it
	
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
		
		var collider_node = collision.get_collider()
		
		if collider_node.is_in_group("pushable"):
			var collision_normal: Vector2 = collision.get_normal()
			
			collider_node.apply_central_force(-collision_normal * push_strength)

func update_treasure_label():
	var treasure_amount: int = SceneManager.opened_chests.size()
	$%TreasureLabel.text = str(treasure_amount)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("interactable"):
		body.can_interact = false

func _on_hitbox_area_2d_body_entered(body: Node2D) -> void:
	SceneManager.player_hp -= 1
	update_hp_bar()
	if SceneManager.player_hp <= 0:
		die()
		
func die():
	SceneManager.player_hp = 4
	get_tree().call_deferred("reload_current_scene")

func update_hp_bar():
	if SceneManager.player_hp == 4:
		%HPBar.play("4_hp")
	elif SceneManager.player_hp == 3:
		%HPBar.play("3_hp")
	elif SceneManager.player_hp == 2:
		%HPBar.play("2_hp")
	elif SceneManager.player_hp == 1:
		%HPBar.play("1_hp")
	else:
		%HPBar.play("0_hp")
		
func attack():
	$AttackDurationTimer.start()
	$Sword.visible = true
	%SwordArea2D.monitoring = true

func _on_sword_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	
func _on_attack_duration_timer_timeout() -> void:
	$Sword.visible = false
	%SwordArea2D.monitoring = false
