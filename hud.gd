extends CanvasLayer
signal start_game
#Update score function
func update_score(score):
	$ScoreLabel.text = str(score)
#Message Label box code
func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout #Wait for timeout signal
	$MessageLabel.text = "Dodge the Creeps" #After gameover show the name of the game
	$MessageLabel.show() #And show the message
	await get_tree().create_timer(1.0).timeout #Create timer with code and pause for a second.
	$Button.show() #Show the start button to start the game
	
func _on_message_timer_timeout():
	$MessageLabel.hide()
	
#On button pressed signal- hide the button and emit the custom start game signal.
func _on_button_pressed():
	$Button.hide()
	emit_signal("start_game")



