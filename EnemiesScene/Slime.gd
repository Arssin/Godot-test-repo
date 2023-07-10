extends CharacterBody2D

var player 


func _on_player_detection_body_entered(body):
	if body.name == "Player":
		player = $"../../Player/Player"
		print(player.global_position)
