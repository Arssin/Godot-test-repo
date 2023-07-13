extends CharacterBody2D


@export var speed = 200
@onready var anim = $AnimationPlayer



func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	if input_direction[0] == -1:
		$AnimatedSprite2D.flip_h = true
	elif input_direction[0] == 1: 
		$AnimatedSprite2D.flip_h = false
	if input_direction:
		velocity = input_direction * speed
		anim.play("Run")
	else: 
		velocity = input_direction * 0
		anim.play("Idle")



func _process(delta):
	get_input()
	move_and_slide()

	

