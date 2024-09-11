extends Node
@export var mob_scene: PackedScene

var score
var highscore_state: bool = false

func game_over() -> void:
	
	$ScoreTimer.stop()
	$MobTimer.stop()
	search_for_high_score()
	$HUD.show_game_over(highscore_state)
	$Music.stop()
	$DeathSound.play()
	
func search_for_high_score():
	
	for value in Global.save_data.highscore_values:
		if score >= value:
			Global.save_data.highscore_index = Global.save_data.highscore_values.find(value,0)
			Global.save_data.highscore_values.insert(Global.save_data.highscore_index, score)
			Global.save_data.highscore_values.pop_back()
			highscore_state = true
			break

func new_game():
	score = 0
	highscore_state = false
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
