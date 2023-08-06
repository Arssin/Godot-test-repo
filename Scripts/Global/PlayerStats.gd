extends Node2D

@export var health = 100:
	get:
		print('get health', health)
	set(value):
		health = value
 
@export var speed = 200
