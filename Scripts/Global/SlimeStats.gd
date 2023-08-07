extends Node2D

@export var health = 60:
	get: 
		return health
	set(value):
		health = value

@export var speed = 50


var player_is_inattack_range = false
var enemy_has_cooldown_attack = false
