extends CharacterBody2D
#
@export var speed = 50
var player = null
var chase_player = false
var enemyIsDead = false

@onready var enemy_anim = $SlimeAnimationPlayer
var health = 60


func _physics_process(delta):
	if enemyIsDead:
		$SlimeAnimationPlayer.play('Death')
		await $SlimeAnimationPlayer.animation_finished
		queue_free()
	elif chase_player:
		velocity = (player.position - position).normalized() * speed
		move_and_collide(velocity * delta)
		$SlimeAnimationPlayer.play('Move')
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$SlimeAnimationPlayer.play('Idle')
		
	
	


func _on_player_detection_body_entered(body):
	player = body
	chase_player = true
	


func _on_player_detection_body_exited(body):
	player = null
	chase_player = false
	


func handle_hit():
	health -= 20
	if health <= 0:
		enemyIsDead = true




