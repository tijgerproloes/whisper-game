extends Area2D

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "player" and body.has_key:
		print("deur open")
		queue_free()
