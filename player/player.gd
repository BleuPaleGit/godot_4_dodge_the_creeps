extends CharacterBody2D
signal hit

@export var max_speed = 350
@export var acceleration = 2000
@export var friction = 2000

var axis = Vector2.ZERO
var screen_size

func _ready(): # Called when the node enters the scene tree for the first time.
	screen_size = get_viewport_rect().size
	hide()

func get_input():
	
	#if Input.get_connected_joypads().size() > 0:
	#	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	#	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	axis.x = int(Input.is_key_label_pressed(KEY_D)) - int(Input.is_key_label_pressed(KEY_Q))
	axis.y = int(Input.is_key_label_pressed(KEY_S)) - int(Input.is_key_label_pressed(KEY_Z))
	
	return axis.normalized()
	
func _physics_process(delta: float) -> void:
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

func _on_area_2d_body_entered(_body: Node2D) -> void:
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$Area2D/AreaCollisionShape.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$Area2D/AreaCollisionShape.disabled = false
