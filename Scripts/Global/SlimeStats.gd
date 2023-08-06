extends Node2D

var health = 60:
	get: 
		return health
	set(value):
		health = value

var speed = 50


var enemy_inattack_range = false
var enemy_cooldown_attack = true
