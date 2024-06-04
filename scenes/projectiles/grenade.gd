extends RigidBody2D

const speed = 500


func explode():
	$AnimationPlayer.play("Explosion")
