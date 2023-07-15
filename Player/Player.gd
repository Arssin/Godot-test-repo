extends CharacterBody2D


@export var Range_attack: PackedScene
@export var speed = 200
@onready var anim = $AnimationPlayer
@onready var wand_attack_point = $Sprites/Wand_attack_point



func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var position_mouse_x = get_global_mouse_position().x
	
	if position_mouse_x < global_position.x:
		$Sprites.scale.x = -1
#		$Sprites/AnimatedSprite2D.flip_h = trues
	elif position_mouse_x > global_position.x: 
		$Sprites.scale.x = 1
#		$Sprites/AnimatedSprite2D.flip_h = false
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
	var bullet_instance = Range_attack.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_position = wand_attack_point.global_position
