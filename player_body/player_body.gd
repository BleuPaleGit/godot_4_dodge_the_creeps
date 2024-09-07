extends CharacterBody2D


@export var speed = 300.0
@export var rotation_speed = 3.0

var rotation_direction = 0

func get_input():
	
	var movement = int(Input.is_key_label_pressed(KEY_S)) - int(Input.is_key_label_pressed(KEY_Z))
	
	rotation_direction = int(Input.is_key_label_pressed(KEY_D)) - int(Input.is_key_label_pressed(KEY_Q))
	
	velocity = transform.x * movement * speed
	

func _physics_process(delta: float) -> void:

	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
