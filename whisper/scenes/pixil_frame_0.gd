extends Sprite2D

@export var required_key: String = "Key1"

func _on_player_touch():
	var game_node = get_node("/root/Main/Game")  # pas 'Main' aan
	if required_key in game_node.key_founded:
		queue_free()
		print("Deur geopend!")
