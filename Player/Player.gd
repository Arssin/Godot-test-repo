extends CharacterBody2D


@export var speed = 300
@onready var anim = $AnimatedSprite2D

#func _ready():
#	anim.play("Idle")


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	
	if input_direction:
		velocity = input_direction * speed
	else: 
		velocity = input_direction * 0



func _process(delta):
	get_input()
	move_and_slide()

	

