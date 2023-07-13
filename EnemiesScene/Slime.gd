extends CharacterBody2D
#
#@export var speed = 50
#var player = null
#var chase_player = false
#
#func _physics_process(delta):
#	if chase_player:
#		velocity = (player.position - position).normalized() * speed
#		move_and_slide()
#		move_and_collide(Vector2(0,0))
#
#func _on_player_detection_body_entered(body):
#	player = body
#	chase_player = true
#
#
#func _on_player_detection_body_exited(body):
#	player = null
#	chase_player = false

var SPEED = 30

onready var attack_timer = $AttackTimer

var velocity = Vector2.ZERO

var player

var randomnum

enum {
	SURROUND,
	ATTACK,
	HIT,
}

var state = SURROUND

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	

	

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			move(player.global_position, delta)
		HIT:
			move(player.global_position, delta)
			print("HIT")
			#Slash ANIM

func move(target, delta):
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()
	
func get_circle_position(random):
	var kill_circle_centre = player.global_position
	var radius = 40

	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)


func _on_AttackTimer_timeout():
	state = ATTACK
