extends CharacterBody2D


var player = null
var chase_player = false
var enemyIsDead = false


@onready var enemy_anim = $SlimeAnimationPlayer
@onready var slime_stats = SlimeStats
@onready var slime_cd = $AttackTimer

var enemy_has_cooldown_attack = false
var player_is_inattack_range = false

func _ready():
	slime_stats.health = 60

func _physics_process(delta):
	attack_player()
	
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


func attack_player():
	if player_is_inattack_range and !enemy_has_cooldown_attack and !enemyIsDead:
		enemy_has_cooldown_attack = true
		$AttackTimer.start()
		PlayerStats.player_health -= 20
		




func _on_enemy_hitbox_body_entered(body):
	if body.has_method('handle_player_dead'):
		player_is_inattack_range = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method('handle_player_dead'):
		player_is_inattack_range = false


func _on_attack_timer_timeout():
	enemy_has_cooldown_attack = false
