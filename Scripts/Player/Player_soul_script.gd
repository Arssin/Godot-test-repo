extends CharacterBody2D



@onready var player_stats = $Player_Stats


func _ready():
	pass 


func _process(delta):
	get_input_soul_player()
	move_and_slide()
	
	
	

func get_input_soul_player():
	var input_direction = Input.get_vector("move_left", "move_right","move_up", "move_down")
	var position_mouse_x = get_global_mouse_position().x
	
	if position_mouse_x < global_position.x:
		pass
	elif position_mouse_x > global_position.x: 
		pass
		
	
	if input_direction:
		velocity = input_direction * player_stats.player_speed
	else: 
		velocity = input_direction * 0
		



