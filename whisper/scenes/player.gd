extends CharacterBody2D

var speed := 200
var keys := 0
var keys_needed := 3
var last_hint := ""

@onready var key1 = $"../key"
@onready var key2 = $"../key2"
@onready var key3 = $"../key3"
@onready var door = $"../door"
@onready var hint_label = $"../HintLabel"

func _ready() -> void:
	print("player started")
	show_hint("Find the whisper keys.")

func _physics_process(delta: float) -> void:
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	dir.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if dir != Vector2.ZERO:
		velocity = dir.normalized() * speed
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	check_key(key1)
	check_key(key2)
	check_key(key3)
	check_door()

	# Make the hint label follow the player
	var float_offset = sin(Time.get_ticks_msec() / 200.0) * 5
	hint_label.global_position = global_position + Vector2(-40, -60 + float_offset)

func check_key(key) -> void:
	if key != null and is_instance_valid(key):
		if global_position.distance_to(key.global_position) < 40:
			keys += 1
			key.queue_free()

			if keys == 1:
				show_hint("A soft whisper.")
			elif keys == 2:
				show_hint("One whisper remains.")
			elif keys == 3:
				show_hint("The door wakes.")

func check_door() -> void:
	if door != null and is_instance_valid(door):
		if global_position.distance_to(door.global_position) < 50:
			if keys >= keys_needed:
				show_hint("The door whispers open.")
				door.queue_free()
			else:
				if keys == 0:
					show_hint("The door is silent.")
				elif keys == 1:
					show_hint("The door listens, but waits.")
				elif keys == 2:
					show_hint("Nearly. One last whisper.")

func show_hint(text: String) -> void:
	if text != last_hint:
		last_hint = text
		print("HINT:", text)
		hint_label.text = text
