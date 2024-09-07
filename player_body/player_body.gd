extends CharacterBody2D

@export var max_speed = 350
@export var acceleration = 1500
@export var friction = 2000

var axis = Vector2.ZERO


func get_input():
	
	axis.x = int(Input.is_key_label_pressed(KEY_D)) - int(Input.is_key_label_pressed(KEY_Q))
	axis.y = int(Input.is_key_label_pressed(KEY_S)) - int(Input.is_key_label_pressed(KEY_Z))
	
	return axis.normalized()
	
func _physics_process(delta: float) -> void:
	
	var screen_size = $Player_Area.screen_size
	var input = get_input()
	
	if input == Vector2.ZERO:

		if velocity.length() > (friction * delta): # deceleration process
			velocity -= velocity.normalized() * (friction * delta)
			
		else:
			velocity = Vector2.ZERO #makes sure there's no residual movements while the player should have stopped

	else:

		velocity += (input * acceleration * delta) #acceleration process
		velocity = velocity.limit_length(max_speed)
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #keep the player center inside the screen
	
	$AnimatedSprite2D.play()
	
	move_and_slide()
