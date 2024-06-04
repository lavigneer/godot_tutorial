extends CharacterBody2D

var can_laser: bool = true
var can_grenade: bool = true

signal laser_fire(pos, direction)
signal grenade_fire(pos, direction)

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):
	# input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	# rotate
	look_at(get_global_mouse_position())

	var player_direction = (get_global_mouse_position() - position).normalized()
	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
		can_laser = false
		Globals.laser_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		$LaserTimer.start()
		laser_fire.emit(selected_laser.global_position, player_direction)
		$GPUParticles2D.emitting = true

	# grenade shooting input
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		can_grenade = false
		Globals.grenade_amount -= 1
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		$GrenadeTimer.start()
		grenade_fire.emit(selected_laser.global_position, player_direction)


func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
