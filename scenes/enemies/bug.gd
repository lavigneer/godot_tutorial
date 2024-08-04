extends CharacterBody2D

var player_nearby: bool = false
var player_in_attack_range: bool = false

var speed: int = 300
var health: int = 20
var vulnerable: bool = true


func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/DamageCooldown.start()
		$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
		$Particles/HitParticles.emitting = true
	if health <= 0:
		await get_tree().create_timer(0.5).timeout
		queue_free()


func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		var direction: Vector2 = (Globals.player_pos - position).normalized()
		velocity = direction * speed
		move_and_slide()


func _on_attack_area_body_exited(_body: Node2D):
	player_in_attack_range = false


func _on_attack_area_body_entered(_body: Node2D):
	player_in_attack_range = true
	$AnimatedSprite2D.play("Attack")


func _on_notice_area_body_exited(_body: Node2D):
	player_nearby = false
	$AnimatedSprite2D.stop()


func _on_notice_area_body_entered(_body: Node2D):
	player_nearby = true
	$AnimatedSprite2D.play("Walk")


func _on_attack_cooldown_timeout():
	$AnimatedSprite2D.play("attack")


func _on_damage_cooldown_timeout():
	vulnerable = true
	$AnimatedSprite2D.material.set_shader_parameter("progress", 0)


func _on_animated_sprite_2d_animation_finished():
	if player_in_attack_range:
		Globals.health -= 10
		$Timers/AttackCooldown.start()
