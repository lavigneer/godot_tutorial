extends LevelParent

@export var inside_level_scene: PackedScene


func _on_gate_player_entered_gate(_body: Node2D):
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, 0.5)
	get_tree().change_scene_to_packed(inside_level_scene)
