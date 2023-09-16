extends CharacterBody2D


@onready var _animated_sprite = $Portal_sprite


var player_entered = false

func _process(delta):
	_animated_sprite.play("portal-animation")
	
	if player_entered == true:
		if Input.is_action_just_pressed("enter_clicked"):
			get_tree().change_scene_to_file("res://Scenes/Levels/town_scene.tscn")
	


func _on_area_2d_body_entered(body):
	if body.has_method('get_input_soul_player'):
		player_entered = true
	


func _on_area_2d_body_exited(body):
	if body.has_method("get_input_soul_player"):
		player_entered = false
