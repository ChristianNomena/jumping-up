extends KinematicBody2D


# Declare member variables here. Examples:
const PESANTEUR = 1.5
const GRAVITY = 1000 * PESANTEUR
const UP = Vector2(0, -1)
const ACCEL = 7
const DECEL = 0.1

var velocity = Vector2()
#var nb_saut = 0
var max_speed = 700


func _ready():
	pass


func _process(delta):
	pass


func _physics_process(delta):
	mouvement_loop()
	
	velocity.y += GRAVITY * delta
	velocity = move_and_slide(velocity, UP)


func mouvement_loop():
	var saut = Input.is_action_just_pressed("player_jump")
	var right = Input.is_action_pressed("player_right")
	var left = Input.is_action_pressed("player_left")
	var dirx = int(right) - int(left)
	
	if dirx == -1:
		velocity.x = max(velocity.x - ACCEL, -max_speed)
		$Sprite.flip_h = true
		$AnimationPlayer.play("marche")
	elif dirx == 1:
		velocity.x = min(velocity.x + ACCEL, max_speed)
		$Sprite.flip_h = false
		$AnimationPlayer.play("marche")
	else:
		velocity.x = lerp(velocity.x, 0, DECEL)
		$AnimationPlayer.play("idle")

	if saut == true and is_on_floor():
		velocity.y = -850
	
	if velocity.y < 0:
		$AnimationPlayer.play("jump")
	if velocity.y > 0:
		$AnimationPlayer.play("fall")


#func animation_loop(animation):
#	if $AnimationPlayer.current_animation != animation:
#		$AnimationPlayer.play(animation)
