extends CharacterBody2D

var speed = 25
var player = null
var chase_player = false


func _on_player_detection_body_entered(body):
	player = body
	chase_player = true


func _on_player_detection_body_exited(body):
	player = null
	chase_player = false
