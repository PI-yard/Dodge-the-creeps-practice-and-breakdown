extends Area2D
signal hit #Give signal when player gets hit by mob
@export var speed = 400 #How fast the player will move(pixels/sec).
var screen_size #Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() #Hide the player on start of a game


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Vector2.ZERO #The players movement vector.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	
	if direction.length() > 0:
		direction = direction.normalized() * speed
		get_node("AnimatedSprite2D").play()
	else:
		get_node("AnimatedSprite2D").stop()
		
	position = position + direction * delta
	#Keep the player inside the screen
	global_position = global_position.clamp(Vector2.ZERO,screen_size)
	#Player animation
	if direction.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = direction.x < 0
		$AnimatedSprite2D.flip_v = false
	elif direction.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0
#Start function to show the player in new position and on the CollisionShape2D when game starts.
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false
#Give signal when rigidbody2D(mob) touches the Area2D(Player)
func _on_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled",true)
	emit_signal("hit")
