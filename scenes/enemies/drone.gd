extends CharacterBody2D

var speed: int = 200


func _process(_delta):
	# direction
	var direction = Vector2.RIGHT
	velocity = direction * 400
	move_and_slide()


func hit():
	print("damage")
