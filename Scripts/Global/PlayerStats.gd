extends Node2D

@export var player_health = 100:
	get:
		return player_health
	set(value):
		player_health = value
 
@export var player_speed = 200

var player_alive = true
