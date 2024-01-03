extends RigidBody2D

@export var min_speed = 50.0
@export var max_speed = 100.0

func _ready():
	$AnimatedSprite2D.play()
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
