extends CharacterBody2D

@onready var canvas_layer = get_parent().get_node("CanvasLayer")

const SPEED = 130.0

func _physics_process(delta):
	var direction = Vector2.ZERO
	
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	direction = direction.normalized()
	velocity = direction * SPEED
	
	move_and_slide()
	
	# 👉 INTERACTIE
	if Input.is_action_just_pressed("interact"):
		canvas_layer.open_task()
