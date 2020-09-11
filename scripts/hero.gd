extends KinematicBody2D


# Declare member variables here. Examples:
const GRAVITY = 1000
const UP = Vector2(0, -1)
const ACCEL = 100

var velocity = Vector2()
var max_speed = 250


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	velocity.x = 0
	_process(delta)
	velocity.y += GRAVITY * delta	
	
	move_and_slide(velocity, UP)
	velocity = move_and_slide(velocity, UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	var saut = Input.is_action_just_pressed("ui_accept")
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var dirx = int(right) - int(left)
	
	if dirx == -1:
		velocity.x = max(velocity.x - ACCEL, -max_speed)
		$Sprite.flip_h = true
		animation_loop("marche")
	elif dirx == 1:
		velocity.x = min(velocity.x + ACCEL, max_speed)
		$Sprite.flip_h = false
		animation_loop("marche")
	else:
		velocity.x = lerp(velocity.x, 0, 0.15)
		animation_loop("idle")
		
func animation_loop(animation):
	if $AnimationPlayer.current_animation != animation:
		$AnimationPlayer.play(animation)
