extends Area2D

func _on_key_body_entered(body: Node2D) -> void:
	if body.name == "player":
		body.has_key = true
		print("sleutel gepakt")
		queue_free()
