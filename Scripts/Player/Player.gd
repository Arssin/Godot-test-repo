extends CharacterBody2D
class_name PLAYER

signal player_fired_attack(range_attack, position, direction)


@export var Range_attack: PackedScene
@export var speed = 200


@onready var anim = $AnimationPlayer
@onready var wand_attack_point = $Sprites/Wand_attack_point
@onready var attack_cd = $Attack_Cooldown


var health = 100


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var position_mouse_x = get_global_mouse_position().x
	
	if position_mouse_x < global_position.x:
		$Sprites.scale.x = -1
	elif position_mouse_x > global_position.x: 
		$Sprites.scale.x = 1
	if input_direction:
		velocity = input_direction * speed
		anim.play("Run")
	else: 
		velocity = input_direction * 0
		anim.play("Idle")



func _process(delta):
	get_input()
	move_and_slide()


func _unhandled_input(event):
	if event.is_action_pressed("attack_mouse"):
		attack_range()
		

func attack_range():
	if attack_cd.is_stopped():
		var bullet_instance = Range_attack.instantiate()
		var target = get_global_mouse_position()
		var direction_to_mouse = wand_attack_point.global_position.direction_to(target).normalized()
		emit_signal("player_fired_attack", bullet_instance, wand_attack_point.global_position, direction_to_mouse)
		attack_cd.start()


func handle_hit():
	health -= 20
	print("player hit ", health)
