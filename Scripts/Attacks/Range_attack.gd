extends Area2D
class_name RANGE_ATTACK

@export var speed = 5

@onready var disappear_timer = $DisappearTimer

var direction := Vector2.ZERO

func _ready():
	disappear_timer.start()


func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		
		global_position += velocity


func set_direction(direction: Vector2):
	self.direction = direction


func _on_disappear_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()
