extends CharacterBody2D


var player = null
var chase_player = false
var enemyIsDead = false


@onready var enemy_anim = $SlimeAnimationPlayer
@onready var slime_stats = $Stats


func _physics_process(delta):
	if enemyIsDead:
		$SlimeAnimationPlayer.play('Death')
		await $SlimeAnimationPlayer.animation_finished
		queue_free()
	elif chase_player:
		velocity = (player.position - position).normalized() * slime_stats.speed
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
	slime_stats.health -= 20
	if slime_stats.health <= 0:
		enemyIsDead = true


func enemy():
	pass



