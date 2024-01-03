extends Node
@export var mob_scene: PackedScene

var score = 0 #Score initial value is 0

func _ready():
	randomize()#Randomize everything and the movement of mob.
	
#Start the game when button is pressed when you will get the custom start_game() signal
func new_game():  
	score = 0
	$HUD.update_score(score) #Reset the score when the game restarts
	
	get_tree().call_group("mobs","queue_free") #Call the mobs and destroy it when new game is started
	$Player.start($StartPosition.position) #Reset the players position
	
	$StartTimer.start()
	$BackgroundMusic.play()
	$HUD.show_message("Get ready!...")
	await $StartTimer.timeout #Wait for 1 seconds and the monster starts coming.
	$ScoreTimer.start() #Start score timer
	$MobTimer.start() #Start mob timer - SEND the mobs!

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$BackgroundMusic.stop()
	$GameOverMusic.play()
	
func _on_mob_timer_timeout():
	#Create a new instance of the Mob Scene.
	var mob = mob_scene.instantiate()
	#Get access to the node MobSpwanLocation
	var mob_spawn_location = get_node("ColorRect/MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf() #Here randf() will generate a random number from 0 to 1.
#Set the mob's direction perpendicul(90degree) to the path direction.
	var direction = mob_spawn_location.rotation + PI/2 #Here PI/2(radian) is 90degrees.
	#Add randomness to the direction
	direction = direction + randf_range(-PI/4,PI/4)
	#Write the direction value to the mob's rotation property
	mob.rotation = direction
	#Set the Mob's position to the random location
	mob.position = mob_spawn_location.position
	#Set the velocity (speed + direction)
	var velocity = Vector2(randf_range(mob.min_speed, mob.max_speed),0)
	mob.linear_velocity = velocity.rotated(direction) #.rotated()-- Rotate the vector in that direction and move
	#Add the mob node as a child of main node
	add_child(mob)


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	



