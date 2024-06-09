extends RigidBody2D

const speed = 500
var explosion_radius: int = 350
var explosion_active: bool = false


func _process(_delta):
	if explosion_active:
		var targets = (
			get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Entity")
		)
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if in_range and "hit" in target:
				target.hit()


func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
