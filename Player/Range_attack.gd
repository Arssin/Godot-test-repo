extends Area2D
class_name RANGE_ATTACK

@export var speed = 5

var direction := Vector2.ZERO



func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction
