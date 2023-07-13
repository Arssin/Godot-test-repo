extends CharacterBody2D
#
@export var speed = 50
var player = null
var chase_player = false

func _physics_process(delta):
	if chase_player:
		velocity = (player.position - position).normalized() * speed
		move_and_collide(velocity * delta)

func _on_player_detection_body_entered(body):
	player = body
	chase_player = true


func _on_player_detection_body_exited(body):
	player = null
	chase_player = false



