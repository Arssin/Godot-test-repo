extends Node2D


func handle_range_attack_spawned(bullet: RANGE_ATTACK, position, direction):
	add_child(bullet)
	bullet.global_position = position
	bullet.set_direction(direction)
