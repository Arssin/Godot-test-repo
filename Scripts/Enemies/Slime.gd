extends CharacterBody2D


var player = null
var chase_player = false
var enemyIsDead = false


@onready var enemy_anim = $SlimeAnimationPlayer
@onready var slime_stats = SlimeStats
@onready var slime_cd = $AttackTimer

func _physics_process(delta):
	enemy()
	
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
	if SlimeStats.enemy_inattack_range and SlimeStats.enemy_cooldown_attack:
		SlimeStats.enemy_cooldown_attack = false
		print('Player took dmg')

	if SlimeStats.enemy_cooldown_attack == false:
		slime_cd.start()
	

func _on_attack_timer_timeout():
	print('calling it')
	SlimeStats.enemy_cooldown_attack = true


func _on_enemy_hitbox_body_entered(body):
	pass # Replace with function body.


func _on_enemy_hitbox_body_exited(body):
	pass # Replace with function body.
