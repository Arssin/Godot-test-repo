extends CharacterBody2D
#
@export var speed = 50
var player = null
var chase_player = false

func _physics_process(delta):
	if chase_player:
		velocity = (player.position - position).normalized() * speed
		move_and_collide(velocity * delta)
		$AnimatedSprite2D.play('Move')
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
			
	else:
		$AnimatedSprite2D.play('Idle')


func _on_player_detection_body_entered(body):
	player = body
	chase_player = true
	


func _on_player_detection_body_exited(body):
	player = null
	chase_player = false



