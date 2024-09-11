extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

func _ready():
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	#Global.save_data.high_score = 10
	#Global.save_data.save()

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over(new_high_score):
			
	if new_high_score == false :
		
		show_message("Game Over")
		# Wait until the MessageTimer has counted down.
		await $MessageTimer.timeout
			
		$Message.text = "Dodge the Creeps!"
		$Message.show()

		# Make a one-shot timer and wait for it to finish.
		await get_tree().create_timer(1.0).timeout
		$StartButton.text = "Restart"
		$StartButton.show()	
	
	else:
		$NewHightScore.show()
		
func update_score(score):
	$ScoreLabel.text = str(score)

func _on_start_button_pressed() -> void:
	$ScoreLabel.show()
	$NewHightScore.hide()
	$LeaderBoard.hide()
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()

func _on_enter_player_name_text_submitted(new_text: String) -> void:
	Global.save_data.highscore_names.insert(Global.save_data.highscore_index, new_text)
	Global.save_data.highscore_names.pop_back()
	Global.save_data.save()
	update_leaderboard()
	$NewHightScore.hide()
	$LeaderBoard.show()
	$StartButton.text = "Restart"
	$StartButton.show()

func update_leaderboard():
	$LeaderBoard/First/PlayerName.text = Global.save_data.highscore_names[0]
	$LeaderBoard/First/Score.text = str(Global.save_data.highscore_values[0])
	$LeaderBoard/Second/PlayerName.text = Global.save_data.highscore_names[1]
	$LeaderBoard/Second/Score.text = str(Global.save_data.highscore_values[1])
	$LeaderBoard/Third/PlayerName.text = Global.save_data.highscore_names[2]
	$LeaderBoard/Third/Score.text = str(Global.save_data.highscore_values[2])
	$LeaderBoard/Fourth/PlayerName.text = Global.save_data.highscore_names[3]
	$LeaderBoard/Fourth/Score.text = str(Global.save_data.highscore_values[3])
	$LeaderBoard/Fifth/PlayerName.text = Global.save_data.highscore_names[4]
	$LeaderBoard/Fifth/Score.text = str(Global.save_data.highscore_values[4])	
